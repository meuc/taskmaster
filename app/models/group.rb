class Group < ActiveRecord::Base
  has_many :users
  has_many :tasks, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true

  def users_and_number_of_tasks
    ["small", "big"].inject({}) do |acc, size|
      acc[size] = users.inject(Hash.new([])) do |acc, user|
        count = user.tasks.where(size: size).count
        acc[count] = acc[count] + [user]
        acc
      end

      acc
    end
  end
end
