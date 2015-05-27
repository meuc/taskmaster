class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create 
    task = Task.find(params[:task_id])
    task_params = params.require(:comment).permit(:image_name)
    @comment = task.comments.create(task_params)
    @comment.update(user_id: current_user.id)
  end
end