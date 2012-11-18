# encoding: utf-8
# == Schema Information
#
# Table name: costumes
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  price        :integer
#  costume_type :string(255)
#  availability :string(255)
#  comment      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Costume < ActiveRecord::Base
  attr_accessible :availability, :name, :price, :costume_type, :comment
  has_and_belongs_to_many :parts
  has_and_belongs_to_many :orders
  has_many :pictures, :as => :pictureable
  
  TYPE_TO_TYPE_NAME = { 'complex' => 'Составной', 'simple' => 'Простой' }
  AVAILABILITY_TO_AVAILABILITY_NAME = { 'y' => 'Доступен', 'n' => 'Недоступен' }
  
  validates :name, presence: true
  validates :costume_type, format: { with: /^\Acomplex|simple\z/ }
  validates :availability, format: { with: /\Ay|n\z/ }
  
  after_initialize :init
  before_validation :validate_associated_pictures
  after_destroy :delete_associated_pictures

  def can_be_added_to_order(order)
    if self.availability == "n"
      return false
    end
    dates = { :begin => order.take_time,
            :end => order.real_return_time.nil? ? order.planed_return_time : order.real_return_time
    };
    if self.does_belong_to_active_order_by_dates(dates)
      return false
    end
    self.parts.each do |part|
      if part.does_belong_to_assigned_costume_by_dates(dates)
        return false
      end
    end
    return true
  end

  def does_belong_to_active_order_by_dates(dates)
    active_orders = self.orders.where({:activity_status => "y"});
    active_orders.each do |order|
      take_time = order.take_time
      return_time = order.real_return_time.nil? ?
        order.planed_return_time : order.real_return_time;
      if self.dates_overlaped?(dates, {:begin => take_time, :end => return_time})
        return true
      end
    end
    return false;
  end
  
  private
  def init
    self.costume_type ||= 'simple'
    self.availability ||= 'y'
  end
  
  def validate_associated_pictures
    self.pictures.each do |picture|
      if !picture.valid?
        return false
      end
    end
  end
  
  def delete_associated_pictures
    self.pictures.each do |picture|
      picture.destroy
    end
  end
  
  protected
  def dates_overlaped?(first_date, second_date)
    return (first_date[:end] < second_date[:begin] or first_date[:begin] > second_date[:end]) ? false : true;
  end
end
