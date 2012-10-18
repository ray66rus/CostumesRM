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
  
end
