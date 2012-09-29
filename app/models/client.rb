# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  phone      :string(255)
#  address    :string(255)
#  contact    :string(255)
#  comment    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Client < ActiveRecord::Base
  attr_accessible :address, :comment, :contact, :email, :name, :phone
  has_many :orders
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  VALID_PHONE_REGEXP = /\A\+?\d?[ \d\-\(\)]+\z/
  validates :phone,
        presence: true, format: { with: VALID_PHONE_REGEXP }, length: { minimum: 7 }
  VALID_EMAIL_REGEXP = /\A([\w+\-\.]+@[a-z\d\-\.]+\.[a-z]+)?\z/i
  validates :email, format: { with: VALID_EMAIL_REGEXP }
end
