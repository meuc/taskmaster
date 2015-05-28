class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u|
      u.permit(:first_name, :last_name, :birthdate, :gender, :email, :password)
    }
  end
  
  private
  
  def require_group!
    unless current_user.group?
      flash[:alert] = "You're not part of a group"
      redirect_to new_group_path
    end
  end
end