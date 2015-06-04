class ContactController < ApplicationController
  def new
  end

  def create
    if params_ok?
      if deliver_email
        flash.notice = "Email sent"
        redirect_to root_path
      else
        flash.alert = "Couldn't send email, make sure all fields are filled out"
        render :new
      end
    else
      flash.alert = "Couldn't send email, make sure all fields are filled out"
      render :new
    end
  end

  private

  def deliver_email
    email = ContactForm.new(
      :email => params[:email],
      :body => params[:body],
      :name => params[:name],
      :subject => params[:subject],
    )
    email.deliver
  end

  def params_ok?
    [
      params[:subject],
      params[:body],
      params[:email],
      params[:name],
    ].all?(&:present?)
  end
end
