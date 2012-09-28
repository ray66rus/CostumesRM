# == Schema Information
#
# Table name: costumes
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  price        :integer
#  type         :string(255)
#  availability :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class CostumeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
