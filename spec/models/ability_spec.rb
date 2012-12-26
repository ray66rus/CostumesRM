# encoding: utf-8

require "spec_helper"
require "cancan/matchers"

describe "Abilities" do
  
  subject { ability }
  
  describe "when user is not signed in" do
    let(:user) { nil }
    let(:ability) { Ability.new(user) }
    
    describe "and trying to manipulate User object" do
      let(:test_user) { User.new }
    
      it { should_not be_able_to(:read, test_user) }
      it { should_not be_able_to(:create, test_user) }
      it { should_not be_able_to(:update, test_user) }
      it { should_not be_able_to(:destroy, test_user) }
      it { should_not be_able_to(:change_user_type, test_user) }
    end

    describe "and trying to manipulate Client object" do
      let(:test_client) { Client.new }
    
      it { should_not be_able_to(:read, test_client) }
      it { should_not be_able_to(:create, test_client) }
      it { should_not be_able_to(:update, test_client) }
      it { should_not be_able_to(:destroy, test_client) }
    end

    describe "and trying to manipulate Order object" do
      let(:test_order) { Order.new }
    
      it { should_not be_able_to(:read, test_order) }
      it { should_not be_able_to(:create, test_order) }
      it { should_not be_able_to(:update, test_order) }
      it { should_not be_able_to(:destroy, test_order) }
    end

    describe "and trying to manipulate Part object" do
      let(:test_part) { Part.new }
    
      it { should_not be_able_to(:read, test_part) }
      it { should_not be_able_to(:create, test_part) }
      it { should_not be_able_to(:update, test_part) }
      it { should_not be_able_to(:destroy, test_part) }
    end

    describe "and trying to manipulate Costume object" do
      let(:test_costume) { Costume.new }
    
      it { should be_able_to(:read, test_costume) }
      it { should_not be_able_to(:create, test_costume) }
      it { should_not be_able_to(:update, test_costume) }
      it { should_not be_able_to(:destroy, test_costume) }
    end
  end

  describe "when user is 'weak' user" do
    let(:user) { FactoryGirl.create(:simpleuser) }
    let(:ability) { Ability.new(user) }
    
    describe "and trying to manipulate User object" do
      let(:test_user) { User.new }
    
      it { should_not be_able_to(:read, test_user) }
      it { should_not be_able_to(:create, test_user) }
      it { should_not be_able_to(:update, test_user) }
      it { should_not be_able_to(:destroy, test_user) }
      it { should_not be_able_to(:change_user_type, test_user) }
      
      describe "of his own" do
        it { should be_able_to(:read, user) }
        it { should be_able_to(:update, user) }
        it { should_not be_able_to(:create, test_user) }
        it { should_not be_able_to(:update, test_user) }
        it { should_not be_able_to(:change_user_type, user) }
      end
    end
    
    describe "and trying to manipulate Client object" do
      let(:test_client) { Client.new }
    
      it { should be_able_to(:read, test_client) }
      it { should_not be_able_to(:create, test_client) }
      it { should_not be_able_to(:update, test_client) }
      it { should_not be_able_to(:destroy, test_client) }
    end
    
    describe "and trying to manipulate Order object" do
      let(:test_order) { Order.new }
    
      it { should be_able_to(:read, test_order) }
      it { should be_able_to(:create, test_order) }
      
      describe "created by other user" do
        it { should_not be_able_to(:update, test_order) }
        it { should_not be_able_to(:destroy, test_order) }
      end

      describe "created by him" do
        before { test_order.user_id = user.id }
        it { should be_able_to(:update, test_order) }
        it { should be_able_to(:destroy, test_order) }
      end
    end

    describe "and trying to manipulate Part object" do
      let(:test_part) { Part.new }
    
      it { should be_able_to(:read, test_part) }
      it { should_not be_able_to(:create, test_part) }
      it { should_not be_able_to(:update, test_part) }
      it { should_not be_able_to(:destroy, test_part) }
    end

    describe "and trying to manipulate Costume object" do
      let(:test_costume) { Costume.new }
    
      it { should be_able_to(:read, test_costume) }
      it { should_not be_able_to(:create, test_costume) }
      it { should_not be_able_to(:update, test_costume) }
      it { should_not be_able_to(:destroy, test_costume) }
    end
  end
  
  describe "when user is power user" do
    let(:user) { FactoryGirl.create(:poweruser) }
    let(:ability) { Ability.new(user) }
    
    describe "and trying to manipulate User object" do
      let(:test_user) { User.new }
    
      it { should_not be_able_to(:read, test_user) }
      it { should_not be_able_to(:create, test_user) }
      it { should_not be_able_to(:update, test_user) }
      it { should_not be_able_to(:destroy, test_user) }
      it { should_not be_able_to(:change_user_type, test_user) }
      
      describe "of his own" do
        it { should be_able_to(:read, user) }
        it { should be_able_to(:update, user) }
        it { should_not be_able_to(:create, test_user) }
        it { should_not be_able_to(:update, test_user) }
        it { should_not be_able_to(:change_user_type, user) }
      end
    end
    
    describe "and trying to manipulate Client object" do
      let(:test_client) { Client.new }    
      it { should be_able_to(:manage, test_client) }
    end
    
    describe "and trying to manipulate Order object" do
      let(:test_order) { Order.new }    
      it { should be_able_to(:manage, test_order) }
    end

    describe "and trying to manipulate Part object" do
      let(:test_part) { Part.new }    
      it { should be_able_to(:manage, test_part) }
    end

    describe "and trying to manipulate Costume object" do
      let(:test_costume) { Costume.new }
      it { should be_able_to(:manage, test_costume) }
    end
  end
  
  describe "when user is admin" do
    let(:user) { FactoryGirl.create(:admin) }
    let(:ability) { Ability.new(user) }
    
    describe "and trying to manipulate User object" do
      let(:test_user) { User.new }    
      it { should be_able_to(:manage, test_user) }
    end
    
    describe "and trying to manipulate Client object" do
      let(:test_client) { Client.new }    
      it { should be_able_to(:manage, test_client) }
    end
    
    describe "and trying to manipulate Order object" do
      let(:test_order) { Order.new }    
      it { should be_able_to(:manage, test_order) }
    end

    describe "and trying to manipulate Part object" do
      let(:test_part) { Part.new }    
      it { should be_able_to(:manage, test_part) }
    end

    describe "and trying to manipulate Costume object" do
      let(:test_costume) { Costume.new }
      it { should be_able_to(:manage, test_costume) }
    end
  end
end
