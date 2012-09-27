class Part < ActiveRecord::Base
  attr_accessible :comment, :name
  has_and_belongs_to_many :costumes
  has_many :images, :as => :imageable
end
