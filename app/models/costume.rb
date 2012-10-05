# encoding: utf-8
# == Schema Information
#
# Table name: costumes
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  price        :integer
#  type         :string(255)
#  availability :string(255)
#  comment      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Costume < ActiveRecord::Base
  attr_accessible :availability, :name, :price, :type, :comment
  has_and_belongs_to_many :parts
  has_and_belongs_to_many :orders
  has_many :pictures, :as => :pictureable
  
  TYPE_TO_TYPE_NAME = { :complex => 'Составной', :simple => 'Простой' }
  AVAILABILITY_TO_AVAILABILITY_NAME = { :y => 'Доступен', :n => 'Недоступен' }
  
  validates :name, presence: true
  validates :type, format: { with: /^\Acomplex|simple\z/ }
  validates :availability, format: { with: /\Ay|n\z/ }
  
  after_initialize :init
  before_validation :validate_associated_pictures
  after_destroy :delete_associated_pictures
  
  def init
    self.type ||= 'simple'
    self.availability ||= 'y'
  end
  
  def validate_associated_pictures
    self.pictures.each do |picture|
      if !picture.validate
        return false
      end
    end
  end
  
  def delete_associated_pictures
    self.pictures.each do |picture|
      picture.destroy
    end
  end
end
