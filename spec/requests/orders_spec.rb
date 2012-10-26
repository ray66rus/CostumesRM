# encoding: utf-8

require 'spec_helper'

describe "OrdersPages" do

  subject { page }

  describe "add order page" do
    before { visit add_order_path }

    it { should have_selector('title', text: full_title('Новый заказ')) }
    it { should have_selector('h1', text: 'Добавление заказа') }
    it { should have_selector('label', text: 'Клиент') }
  end
end