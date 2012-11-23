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
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :user_type
  has_many :orders
  
  has_secure_password
  
  validates :name, :password, :password_confirmation, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
      uniqueness: { case_sensitive: false }
  validates :user_type, presence: true, format: { with: /\Aadmin|guest|user|poweruser\z/ }
  before_save { |user| user.email = email.downcase }

  TYPE_TO_TYPE_NAME = { "admin" => I18n.t("user.constants.user_types.admin"),
    "guest" => I18n.t("user.constants.user_types.guest"),
    "user" => I18n.t("user.constants.user_types.user"),
    "poweruser" => I18n.t("user.constants.user_types.poweruser")
  }
  
end
