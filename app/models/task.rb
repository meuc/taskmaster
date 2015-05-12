class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  
  validates :name, presence: true
  validates :size, presence: true
  validates :interval, presence: true
  
  def toggle_completed
    if completed_at?
      update completed_at: nil
    else
      update completed_at: Time.now
    end
  end
  
  def assign_user
    self.user = get_least_busy_user_in_group
    self.save!
  end
  
  private
  
  def get_least_busy_user_in_group
    users_and_number_of_tasks = group.users.map do |user|
      number_of_tasks = user.tasks.count
      [user, number_of_tasks]
    end
    
    sorted_users_and_count = users_and_number_of_tasks.sort_by do |user_and_count|
      user_and_count.last
    end
    
    user_with_least_tasks = sorted_users_and_count.first.first
    
    user_with_least_tasks
  end
end
