# == Schema Information
#
# Table name: images
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  url            :string(255)
#  imageable_id   :integer
#  imageable_type :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
