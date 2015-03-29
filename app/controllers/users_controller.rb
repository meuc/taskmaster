# Controller is the thing that sits between the HTML and the datebase. It takes stuff out of the database and gives it to the HTML.
class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
end