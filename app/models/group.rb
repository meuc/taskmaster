class Group < ActiveRecord::Base
  has_many :users
  has_many :tasks, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
end