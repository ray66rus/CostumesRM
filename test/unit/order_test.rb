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

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
