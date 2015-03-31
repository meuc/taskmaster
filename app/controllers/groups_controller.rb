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

    users = params[:users].map do |email|
      User.find_by_email(email)
    end

    if @group.valid? && users.all?(&:present?)
      @group.save
      current_user.update!(group_id: @group.id)

      users.each do |user|
        user.update(group_id: @group.id)
      end

      redirect_to @group
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
end

# TODO: remove create group link on create group page or make less prominent