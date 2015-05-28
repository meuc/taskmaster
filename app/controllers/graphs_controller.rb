class GraphsController < ApplicationController  
  before_action :authenticate_user!
  before_action :require_group!
  
  def index
    @users = current_user.group.users
    
    respond_to do |format|
      format.html {}
      format.json {
        json = current_user.group.users.reduce({}) do |acc, user|
          acc["#{user.first_name} #{user.last_name}"] = user.total_score
          acc
        end
        
        render json: json
      }
    end
  end
end