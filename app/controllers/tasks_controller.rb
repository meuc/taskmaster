require "grouper"

class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :require_group!
  
  def new
    @task = Task.new
  end
  
  def create
    task_params = params.require(:task).permit( :name,
                                                :size,
                                                :interval)
    @task = Task.new(task_params)
    
    @task.group = current_user.group
    
    if @task.save 
      redirect_to tasks_path
    else
      render :new
    end
  end
  
  def index
    @tasks = Grouper.new(current_user.group.tasks).group_by(:size, :interval)
  end
  
  def destroy
    @task = Task.find(params[:id])
    
    @task.destroy
    flash[:notice] = "Task has been removed"
    redirect_to tasks_path
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    task_params = params.require(:task).permit( :name,
                                                :size,
                                                :interval)
    @task = Task.find(params[:id])
        
    if @task.update(task_params) 
      redirect_to tasks_path
    else
      render :edit
    end
  end
  
  private
  
  def require_group!
    unless current_user.group?
      flash[:alert] = "You're not part of a group"
      redirect_to new_group_path
    end
  end
end