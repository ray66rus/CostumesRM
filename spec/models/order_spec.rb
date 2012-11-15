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


require 'spec_helper'

describe "Order" do
  
  before {
    @order = Order.new(take_time: "11.11.2012", planed_return_time: "12.11.2012")
    @order.client = Client.new(name: "Тестовый клиент")
    @order.costumes << Costume.new({name: 'Тестовый костюм', price: 100})
  }
  
  subject { @order }
  
  it { should respond_to(:price) }
  it { should respond_to(:payed_status) }
  it { should respond_to(:activity_status) }
  it { should respond_to(:take_time) }
  it { should respond_to(:planed_return_time) }
  it { should respond_to(:real_return_time) }
  it { should respond_to(:user) }
  it { should respond_to(:comment) }
  it { should respond_to(:client) }
  it { should respond_to(:costumes) }
  it { should respond_to(:active?) }
  it { should respond_to(:payed?) }
  
  it { should be_valid }
  
  describe "when price is default" do
    it { @order.price.should == 0 }
  end
  
  describe "when payed_status is default" do
    it { @order.payed_status.should == "n" }
  end

  describe "when activity_status is default" do
    it { @order.payed_status.should == "n" }
  end

  describe "when has no costume" do
    before { @order.costumes.delete(@order.costumes.first) }
    it { should_not be_valid }
  end
  
  describe "when has no take_time" do
    it {
      @order.take_time = nil
      should_not be_valid
    }
  end

  describe "when has no return_time" do
    it {
      @order.planed_return_time = nil
      should_not be_valid
    }
  end

  describe "planed_return_time is greater than take_time" do
    it {
      @order.take_time = "12.12.2012"
      @order.planed_return_time = "11.11.2012"
      should_not be_valid
    }
  end

  describe "when has no client" do
    before { @order.client = nil }
    it { should_not be_valid }
  end
  
  describe "when payed status is wrong" do
    before { @order.payed_status = 'q' }
    it { should_not be_valid }
  end

  describe "when activity status is wrong" do
    before { @order.activity_status = 'q' }
    it { should_not be_valid }
  end
  
  it { @order.delete }
  
end
