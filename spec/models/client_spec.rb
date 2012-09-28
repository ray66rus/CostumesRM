# encoding: utf-8

require 'spec_helper'

describe "Client" do
  
  before { @client = Client.new(name: "Малыш и Ка",
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
  
end