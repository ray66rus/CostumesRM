# encoding: utf-8

require 'spec_helper'

describe "OrdersPages" do

  subject { page }
  
  let(:user) { FactoryGirl.create(:poweruser) }
  before { sign_in user }

  describe "add order page" do
    before { visit add_order_path }

    it { should have_selector('title', text: full_title('Добавление заказа')) }
    it { should have_selector('h1', text: 'Создание заказа') }
    it { should have_selector('label', text: 'Клиент') }
    it { should have_selector('label', text: 'Цена') }
    it { should have_selector('label', text: 'Оплачен:') }
    it { should have_selector('label', text: 'Костюмы') }
    it { should have_selector('label', text: 'Дата выдачи:') }
    it { should have_selector('label', text: 'Дата возврата (планируемая):') }
    it { should have_selector('label', text: 'Дата возврата (фактическая):') }
    it { should have_selector('label', text: 'Комментарий') }
  end
  
  describe "list orders page" do
    before { visit list_orders_path }
    
    it { should have_selector('title', text: full_title('Заказы')) }
    it { should have_selector('h1', text: 'Список заказов') }
    it { should have_selector('div', text: 'Операции') }
    it { should have_selector('div', text: 'Клиент') }
    it { should have_selector('div', text: 'Костюмы') }
    it { should have_selector('div', text: 'Сумма') }
    it { should have_selector('div', text: 'Дата выдачи') }
    it { should have_selector('div', text: 'Дата возврата') }
    it { should have_selector('div', text: 'Комментарий') }
    it { should have_selector('a', text: 'Создать заказ') }
  end
  
  describe "edit order page" do
    let(:order) { FactoryGirl.create(:order) }
    before { visit edit_order_path(order) }
    
    it { should have_selector('title', text: full_title('Изменение заказа')) }
    it { should have_selector('h1', text: 'Изменение данных заказа') }
    it { should have_selector('label', text: 'Клиент') }
    it { should have_selector('label', text: 'Цена') }
    it { should have_selector('label', text: 'Оплачен:') }
    it { should have_selector('label', text: 'Костюмы') }
    it { should have_selector('label', text: 'Дата выдачи:') }
    it { should have_selector('label', text: 'Дата возврата (планируемая):') }
    it { should have_selector('label', text: 'Дата возврата (фактическая):') }
    it { should have_selector('label', text: 'Комментарий') }
  end
end