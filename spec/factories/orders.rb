# encoding: utf-8

FactoryGirl.define do
  factory :order do
    price 100
    client { FactoryGirl.create(:client) }
    costumes { [ FactoryGirl.create(:costume) ] }
  end
end