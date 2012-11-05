# encoding: utf-8

FactoryGirl.define do
  factory :order do
    take_time "11.11.2012"
    price 100
    client { FactoryGirl.create(:client) }
    costumes { [ FactoryGirl.create(:costume) ] }
  end
end