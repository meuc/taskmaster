# Controller is the thing that sits between the HTML and the datebase. It takes stuff out of the database and gives it to the HTML.
require "grouper"

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tasks = Grouper.new(@user.tasks).group_by(:size, :interval)
  end
  
  def destroy
    user = User.find(params[:id])
    
    if user == current_user
      user_tasks = user.tasks
    
      user_tasks.each do |task|
        task.update! user_id: nil
      end
      
      if user.group.present?
        user.group.users.delete(user)
      end
      
      sign_out
      
      user.destroy
    else
      flash[:alert] = "You can only delete your own profile!"
    end
    
    redirect_to root_path
  end
end