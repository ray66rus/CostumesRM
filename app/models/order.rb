# == Schema Information
#
# Table name: orders
#
#  id                 :integer          not null, primary key
#  price              :integer
#  payed_status       :string(255)
#  activity_status    :string(255)
#  take_time          :datetime
#  planed_return_time :datetime
#  real_return_time   :datetime
#  user_id            :integer
#  client_id          :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Order < ActiveRecord::Base
  attr_accessible :activity_status, :payed_status, :price, :take_time, :planed_return_time, :real_return_time
  has_and_belongs_to_many :costumes
  belongs_to :user
  belongs_to :client
end
