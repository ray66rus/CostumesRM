# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  user_type       :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  attr_readonly :user_type
  has_many :orders
  
  has_secure_password
  
  validates :name, :password, :password_confirmation, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
      uniqueness: { case_sensitive: false }
  validates :user_type, presence: true, format: { with: /\Aadmin|user|poweruser\z/ }
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  after_initialize { |user| user.user_type ||= 'user' }

  TYPE_TO_TYPE_NAME = { "user" => I18n.t("user.constants.user_types.user"),
    "poweruser" => I18n.t("user.constants.user_types.poweruser"),
    "admin" => I18n.t("user.constants.user_types.admin")
  }
  
  def admin?
    self.user_type == 'admin'
  end
  
  def user?
    self.user_type == 'user'
  end
  
  def power_user?
    self.user_type == 'poweruser'
  end
  
  private
  
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
