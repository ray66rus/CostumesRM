class Client < ActiveRecord::Base
  attr_accessible :address, :comment, :contact, :email, :name, :phone
  has_many :orders
end
