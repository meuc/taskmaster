class AssignmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_group!
  
  def edit
    @tasks = current_user.group.tasks
  end
  
  def update
    params[:task].each do |task_id, user_id|
      Task.find(task_id).update(user_id: user_id)
    end
    
    redirect_to tasks_path
  end
  
  def auto
    group = current_user.group
    group.tasks.each(&:assign_user)
    group.update(auto_assigned_at: Time.now)
    
    redirect_to tasks_path
  end
end