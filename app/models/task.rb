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
  
  def give_score
    if completed_at?
      Score.create! user_id: user.id, points: points_worth
    else
      Score.where(user_id: user.id, points: points_worth).order(created_at: :desc).first.destroy!
    end
  end
  
  private
  
  def points_worth
    if size == "big"
      if interval == "monthly"
        12
      elsif interval == "weekly"
        10
      else
        2
      end
    else
      if interval == "monthly"
        6
      elsif interval == "weekly"
        5
      else
        1
      end
    end
  end
end
