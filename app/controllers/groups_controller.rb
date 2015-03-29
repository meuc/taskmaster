class GroupsController < ApplicationController
  before_action :authenticate_user!
  def new
    @group = Group.new
  end
  
  def create
    group_params = params.require(:group).permit(:name)
    @group = Group.new(group_params)
    
    if @group.save
      current_user.update group_id: @group.id
      redirect_to @group
    else
      render :new
    end
  end
  
  def show
    @group = Group.find(params[:id])
    
    if @group != current_user.group
      flash[:error] = "You are not a member of this group"
      redirect_to root_path
    end
  end
end