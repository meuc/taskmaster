class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  belongs_to :group
  has_many :tasks
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  def with_or_without_s
    last = first_name.last
    if last == "s"
      first_name + "'"
    else
      first_name + "'s"
    end
  end
  
  def group?
    group_id.present?
  end
end

# TODO: confirmation emails to avoid fake email stuff
