class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  
  validates :name, presence: true
  validates :size, presence: true
  validates :interval, presence: true
  
end