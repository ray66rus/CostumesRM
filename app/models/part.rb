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
  
  validates :name, presence: true
  
  after_save :create_associated_costume
  before_destroy :check_costumes_count
  after_destroy :delete_associated_costume
  
  def create_associated_costume
    self.costumes << Costume.create(:name => self.name)
  end
  
  def check_costumes_count
    if self.costumes.length > 1
      return false
    end
    
    attached_costume = Costume.find(self.costumes.first)
    if !attached_costume.nil?
      attached_costume.destroy
    end

  end
  
  def delete_associated_costume    
    if(self.costumes.length > 0)
      return false
    end
  end
end
