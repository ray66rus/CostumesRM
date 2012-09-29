# encoding: utf-8

require 'spec_helper'

describe "Client" do
  
  before { @client = Client.new(name: "Малыш & Ка",
                                phone: "+79169999999",
                                email: "foo@foo.bar",
                                address: "Moscow, Big basmannaya, 25",
                                contact: "John Doe",
                                comment: "хорошие, годные клиенты\nзажали два костюма") }
  
  subject { @client }
  
  it { should respond_to(:name) }
  it { should respond_to(:phone) }
  it { should respond_to(:email) }
  it { should respond_to(:address) }
  it { should respond_to(:contact) }
  it { should respond_to(:comment) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before { @client.name = " " }
    it { should_not be_valid }
  end
  
  describe "when phone is not present" do
    before { @client.phone = " " }
    it { should_not be_valid }
  end

  describe "when email is not valid" do
    it "should be invalid" do
     address = %w[abs@foo,com user_at_foo_org example.user@foo.
                foo@bar_vza.com foo@bar+baz.com]
     address.each do |invalid_email|
        @client.email = invalid_email
        @client.should_not be_valid
      end
    end
  end

  describe "when email is valid" do
    it "should be valid" do
     address = %w[user@foo.COM A_US-ER@f.b.org frst.lst@fpp.jp a+b@bar.cn]
     address.push('');
     address.each do |valid_email|
        @client.email = valid_email
        @client.should be_valid
      end
    end
  end
  
  describe "when phone is not valid" do
    it "should be invalid" do
     phones = %w[abs 123456]
     phones.each do |invalid_phone|
        @client.phone = invalid_phone
        @client.should_not be_valid
      end
    end
  end

  describe "when phone is valid" do
    it "should be valid" do
      phones = %w[+79169999999 8-916-999-99-99 8(916)999-99-99]
      phones.push("8 (916) 999 99 99", "8 (916) 999-99-99", "8 916 999-99-99")
      phones.each do |valid_phone|
        @client.phone = valid_phone
        @client.should be_valid
      end
    end
  end
  
  describe "when name is already taken" do
    before do
      client_with_same_name = @client.dup
      client_with_same_name.save
    end
    
    it { should_not be_valid }
  end
  
end