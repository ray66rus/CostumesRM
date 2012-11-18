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


require 'spec_helper'

describe "Costume" do
  
  before {
    @costume = Costume.new(name: 'Сложный костюм',
                                price: 111,
                                comment: 'сложный комментарий')
  }

  subject { @costume }
  
  it { should respond_to(:name) }
  it { should respond_to(:comment) }
  it { should respond_to(:price) }
  it { should respond_to(:availability) }
  it { should respond_to(:costume_type) }
  it { should respond_to(:does_belong_to_active_order_by_dates) }
  it { should respond_to(:can_be_added_to_order) }
  
  it { should be_valid }
  it { @costume.costume_type.should == 'simple' }
  it { @costume.availability.should == 'y' }
    
  describe "when name is not present" do
    before { @costume.name = " " }
    it { should_not be_valid }
  end
  
  describe "when type is wrong" do
    before { @costume.costume_type = "wrong type" }
    it { should_not be_valid }
  end

  describe "when availability is wrong" do
    before { @costume.availability = 'q' }
    it { should_not be_valid }
  end
  
  describe "when adding to order" do
    let(:first_order) { FactoryGirl.create(:order) }
    let(:second_order) { FactoryGirl.create(:order) }
    before {
      first_order.take_time = "10.11.2011"
      first_order.planed_return_time = "12.11.2011"
      first_order.costumes << @costume
      first_order.save!
      @simple_costume_from_part = Costume.find_by_name("Белая рубашка")
    }
    
    it {
      second_order = Order.new({take_time: "09.11.2011", planed_return_time: "11.11.2011"})
      @costume.can_be_added_to_order(second_order).should be_false
      @simple_costume_from_part.can_be_added_to_order(second_order).should be_false
      second_order = Order.new({take_time: "11.11.2011", planed_return_time: "13.11.2011"})
      @costume.can_be_added_to_order(second_order).should be_false
      @simple_costume_from_part.can_be_added_to_order(second_order).should be_false
      second_order = Order.new({take_time: "09.11.2011", planed_return_time: "13.11.2011"})
      @costume.can_be_added_to_order(second_order).should be_false
      @simple_costume_from_part.can_be_added_to_order(second_order).should be_false
      second_order = Order.new({take_time: "10.11.2011", planed_return_time: "11.11.2011"})
      @costume.can_be_added_to_order(second_order).should be_false
      @simple_costume_from_part.can_be_added_to_order(second_order).should be_false
      second_order = Order.new({take_time: "08.11.2011", planed_return_time: "09.11.2011"})
      @costume.can_be_added_to_order(second_order).should be_true
      @simple_costume_from_part.can_be_added_to_order(second_order).should be_true
      second_order = Order.new({take_time: "13.11.2011", planed_return_time: "14.11.2011"})
      @costume.can_be_added_to_order(second_order).should be_true
      @simple_costume_from_part.can_be_added_to_order(second_order).should be_true
    }
  end
end
