class User < ActiveRecord::Base
  belongs_to :group
  has_many :tasks
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: { 
    with: /.+@.+\..+/,
    message: "has incorrect format" 
  }
  
  validates :gender, presence: true
  validates :birthdate, presence: true
  
  def with_or_without_s
    last = first_name.last
    if last == "s"
      first_name + "'"
    else
      first_name + "'s"
    end
  end
end

# TODO: confirmation emails to avoid fake email stuff