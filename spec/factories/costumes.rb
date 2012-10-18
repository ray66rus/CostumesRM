# encoding: utf-8

FactoryGirl.define do
  factory :costume do
    name "Тестовый костюм"
    price 100
    costume_type "complex"
    comment "комментарий\nк тестовому\nкостюму"
  end
  
  trait :simple do
    costume_type "simple"
  end
end
