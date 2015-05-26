class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  
  has_many :comments

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
    self.user = PickUser.call(group.users_and_number_of_tasks, size.downcase)
    self.save!
  end
end
