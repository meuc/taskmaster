class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  
  validates :image_name, presence: true
end