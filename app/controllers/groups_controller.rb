class GroupsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @group = Group.new
    
    if current_user.group?
      flash[:alert] = "You are already in a group"
      redirect_to root_path
    end
  end
  
  def create
    group_params = params.require(:group).permit(:name)
    @group = Group.new(group_params)

    users = params[:users].select(&:present?).map do |email|
      User.find_by_email(email)
    end

    if @group.valid? && users.all?(&:present?)
      @group.save
      current_user.update!(group_id: @group.id)

      users.each do |user|
        user.update(group_id: @group.id)
      end

      if params[:add_suggested_tasks]
        redirect_to tasks_add_suggested_path
      else
        redirect_to @group
      end
    else
      flash[:alert] = "There was an error"
      render :new
    end
  end
    
  def show
    @group = Group.find(params[:id])
    
    if @group != current_user.group
      flash[:alert] = "You are not a member of this group"
      redirect_to root_path
    end
  end
  
  def destroy
    @group = Group.find(params[:id])
    
    @group.users.each do |user|
      user.update group_id: nil
    end
    
    @group.destroy
    flash[:notice] = "Group has been deleted"
    redirect_to root_path
  end
  
  def leave
    @group = Group.find(params[:id])
    
    current_user_tasks = current_user.tasks
    
    current_user_tasks.each do |task|
      task.update! user_id: nil
    end
    
    @group.users.delete(current_user)
    
    current_user_tasks.each do |task|
      task.assign_user
    end
    
    flash[:notice] = "You left the group"
    redirect_to root_path
  end
  
  def choose_user  
  end
  
  def add_user
    @group = Group.find(params[:id])

    users = params[:users].select(&:present?).map do |email|
      User.find_by_email(email)
    end

    if users.all?(&:present?)
      users.each do |user|
        user.update(group_id: @group.id)
      end
      
      @group.tasks.each do |task|
        task.update(user_id: nil)
      end
      
      @group.tasks.each do |task|
        task.assign_user
      end
      
      redirect_to @group
    else
      flash[:alert] = "One or more email addresses not existent."
      render :choose_user
    end
  end
end

# TODO: remove create group link on create group page or make less prominent