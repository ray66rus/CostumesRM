# encoding: utf-8

FactoryGirl.define do
  factory :client do
    name	"Тестовый клиент"
    phone	"+7 (916) 999 99 99"
    email	"foo@foo.bar"
    address	"125125, New Vasyky, Lenina st. 1"
    contact	"Вассисуалий Лоханкин"
    comment	"раз два три четыре пять\nвышел вася погулять"
  end
end
