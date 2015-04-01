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
end