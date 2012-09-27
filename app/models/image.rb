class Image < ActiveRecord::Base
  attr_accessible :name, :url
  belongs_to :imageable, :polymorphic => true
end
