# Controller is the thing that sits between the HTML and the datebase. It takes stuff out of the database and gives it to the HTML.
require "grouper"

class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @tasks = Grouper.new(@user.tasks).group_by(:size, :interval)
  end
end