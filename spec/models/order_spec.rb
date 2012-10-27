# encoding: utf-8

require 'spec_helper'

describe "Order" do
  
  before {
    @order = Order.new(take_time: "11.11.2012")
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
  it { should respond_to(:client) }
  it { should respond_to(:costumes) }
  
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