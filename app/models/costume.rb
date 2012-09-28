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

class Costume < ActiveRecord::Base
  attr_accessible :availability, :name, :price, :type
  has_and_belongs_to_many :parts
  has_and_belongs_to_many :orders
  has_many :images, :as => :imageable
end
