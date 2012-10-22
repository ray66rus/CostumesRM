# encoding: utf-8
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

require 'spec_helper'

describe "Part" do
  
  before { @part = Part.new(name: "Рубашка белая",
                                place: "Ряд пять, верхняя полка",
                                comment: "Обычная такая рубашка.\nБелая.") }

  subject { @part }
  
  it { should respond_to(:name) }
  it { should respond_to(:comment) }
  it { should respond_to(:place) }
  it { should respond_to(:can_be_added_to_costume?) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before { @part.name = " " }
    it { should_not be_valid }
  end

  before { @part.save }
  
  describe "when created" do
    before { @costumes = @part.costumes }
    
    it "should belong to one costume" do
      @costumes.length.should == 1
    end
    
    it "should have the same name with costume" do
      @costumes.first.name.should eq(@part.name)
    end
    
    it "can be added to costume" do
      @part.can_be_added_to_costume?.should be_true
    end
  end

  describe "when destroing with two costumes attached" do
    before { @part.costumes.create(:name => "new costume") }

    it "can't be added to costume" do
      @part.can_be_added_to_costume?.should be_false
    end

    it "couldn't be deleted when costumes attached" do
      @part.costumes.length.should == 2
      @part.destroy.should be_false
    end
  end
  
  describe "when destroing with one costume attached" do
    it "should have one costume in database" do
      costume_id = @part.costumes.first.id
      Costume.find(costume_id).should_not be_nil
      Costume.all.length.should == 1
    end
    
    it "could be deleted when no costumes attached" do
      @part.destroy.should be_true
      Costume.all.length.should == 0
    end
  end
  
end
