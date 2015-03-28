class User < ActiveRecord::Base
  belongs_to :group
  has_many :tasks
  
  def with_or_without_s
    last = first_name.last
    if last == "s"
      first_name + "'"
    else
      first_name + "'s"
    end
  end
end

