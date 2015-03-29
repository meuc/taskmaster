class Group < ActiveRecord::Base
  has_many :users
  has_many :tasks
  
  validates :name, presence: true, uniqueness: true
end