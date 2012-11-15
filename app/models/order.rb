# encoding: utf-8
# == Schema Information
#
# Table name: orders
#
#  id                 :integer          not null, primary key
#  price              :integer
#  payed_status       :string(255)
#  activity_status    :string(255)
#  take_time          :datetime
#  planed_return_time :datetime
#  real_return_time   :datetime
#  user_id            :integer
#  client_id          :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  comment            :text
#

class OrderValidator < ActiveModel::Validator
  def validate(record)
    check_times(record)
    check_costumes(record)
    check_client(record)
  end
  
  private
  def check_times(record)
    if(record.planed_return_time.nil? || record.take_time.nil?)
      return
    end
    if record.planed_return_time < record.take_time
      record.errors.add(:planed_return_time, I18n.t("order.errors.return_time_is_too_early"))
    end
  end
  
  def check_costumes(record)
    if record.costumes.size == 0
      record.errors.add(:costumes, I18n.t("order.errors.no_costumes"))
    end
  end
  
  def check_client(record)
    if record.client.nil?
      record.errors.add(:client, I18n.t("order.errors.no_client"));
    end
  end
end

class Order < ActiveRecord::Base
  include ActiveModel::Validations
  attr_accessible :activity_status, :payed_status, :price, :take_time, :planed_return_time, :real_return_time, :comment
  has_and_belongs_to_many :costumes
  belongs_to :user
  belongs_to :client
  
  PAYED_TO_PAYED_NAME_MAP = { 'y' => 'Оплачен', 'n' => 'Не оплачен' }
  ACTIVE_TO_ACTIVE_NAME_MAP = { 'y' => 'В работе', 'n' => 'Архивный' }
  
  REGEXP = /\Ay|n\z/
  validates :activity_status, :payed_status, :format => { with: REGEXP }
  validates :take_time, :planed_return_time, :presence => true
  validates_with OrderValidator
  
  after_initialize :init
  
  def active?
    return self.activity_status == "y"
  end
  
  def payed?
    return self.payed_status == "y"
  end
  
  private
  def init
    self.price ||= '0'
    self.payed_status ||= 'n'
    self.activity_status ||= 'y'
    self.take_time ||= DateTime.now
    self.planed_return_time ||= DateTime.now
  end
end
