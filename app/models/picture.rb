class Picture < ActiveRecord::Base
  attr_accessible :image
  has_attached_file :image
  
  belongs_to :pictureable, :polymorphic => true
end
