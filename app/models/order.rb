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

class Order < ActiveRecord::Base
  attr_accessible :activity_status, :payed_status, :price, :take_time, :planed_return_time, :real_return_time, :comment
  has_and_belongs_to_many :costumes
  belongs_to :user
  belongs_to :client
  
  PAYED_TO_PAYED_NAME_MAP = { 'y' => 'Оплачен', 'n' => 'Не оплачен' }
  ACTIVE_TO_ACTIVE_NAME_MAP = { 'y' => 'В работе', 'n' => 'Архивный' }
  
  REGEXP = /\Ay|n\z/
  validates :activity_status, format: { with: REGEXP }
  validates :payed_status, format: { with: REGEXP }
  
  after_initialize :init
  before_validation :validate_costumes_and_users
  
  private
  def init
    self.price ||= '0'
    self.payed_status ||= 'n'
    self.activity_status ||= 'y'
  end
  
  def validate_costumes_and_users
    return (self.costumes.size > 0) && !self.client.nil?
  end
  
end
