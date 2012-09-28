# == Schema Information
#
# Table name: parts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  place      :string(255)
#  comment    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Part < ActiveRecord::Base
  attr_accessible :comment, :name, :place
  has_and_belongs_to_many :costumes
  has_many :images, :as => :imageable
end
