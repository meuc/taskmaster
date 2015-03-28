# Controller is the thing that sits between the HTML and the datebase. It takes stuff out of the database and gives it to the HTML.
class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    user_params = params.require(:user).permit( :first_name, 
                                                :last_name, 
                                                :email, 
                                                :birthdate, 
                                                :gender)
    @user = User.new(user_params)
    @user.save
    redirect_to @user
  end
end