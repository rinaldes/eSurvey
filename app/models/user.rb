class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username],
         :reset_password_keys => [:username, :email]
  
  attr_accessor :password, :password_confirmation, :remember_me
  
  # validates_confirmation_of :password
  # validates_presence_of :password, :on => :create
  validates_presence_of [:username, :first_name, :last_name, :gender, :birth_place, :birth_date, :role, :status]
  validates_uniqueness_of [:username]
  
  mount_uploader :image, ImageUploader

  self.per_page = 5

  before_save :encrypt_password

  has_many :surveys
  has_many :survey_responses

  def encrypt_password
    if password.present?
      self.encrypted_password = BCrypt::Password.create(password)
    end
  end
  
  def self.set_per_page(number)
    self.per_page = number
  end

  def name
  	self.first_name + " " + self.last_name
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end
end
