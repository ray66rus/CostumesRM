class Order < ActiveRecord::Base
  attr_accessible :activity_status, :payed_status, :price, :take_time, :planed_return_time, :real_return_time
  has_and_belongs_to_many :costumes
  belongs_to :user
  belongs_to :client
end
