class Costume < ActiveRecord::Base
  attr_accessible :availability, :name, :price, :type
  has_and_belongs_to_many :parts
  has_and_belongs_to_many :orders
  has_many :images, :as => :imageable
end
