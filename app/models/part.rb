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
  has_many :pictures, :as => :pictureable
  
  validates :name, presence: true
  
  after_save :create_associated_costume
  before_destroy :delete_associated_costume
  after_destroy :delete_associated_pictures
  
  def can_be_added_to_costume?
    return self.costumes.length < 2
  end
  
  private
  def create_associated_costume
    if self.costumes.length == 0
      self.costumes.create(:name => self.name)
    end
    attached_costume = self.costumes.first;
    attached_costume.name = self.name
  end
  
  def delete_associated_costume
    if self.costumes.length > 1
      return false
    end
    
    if self.costumes.length == 0
      return true
    end
    
    attached_costume = Costume.find(self.costumes.first)
    if !attached_costume.nil?
      return attached_costume.destroy ? true : false
    end
  end
  
  def delete_associated_pictures
    self.pictures.each do |picture|
      picture.destroy
    end
  end
end
