class RegistrationsController < Devise::RegistrationsController
  private

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :birthdate, :gender, :avatar, :password, :password_confirmation, :current_password)
  end

  def after_update_path_for(resource)
    user_path(resource)
  end
end