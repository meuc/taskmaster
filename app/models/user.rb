class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  before_save do
    self.first_name = self.first_name.titleize
    self.last_name = self.last_name.titleize
  end
  
  has_attached_file :avatar, :styles => { :medium => "200x200>", :thumb => "25x25>" }, :default_url => "missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  belongs_to :group
  has_many :tasks
  has_many :comments
  has_many :scores
  
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
  
  def total_score
    scores.pluck(:points).reduce(0, :+)
  end
end

# TODO: confirmation emails to avoid fake email stuff
