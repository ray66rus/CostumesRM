# encoding: utf-8

require 'spec_helper'

describe "ClientPages" do

  subject { page }

  describe "add client page" do
    before { visit add_client_path }

    it { should have_selector('h1', text: 'Добавление клиента') }
    it { should have_selector('title', text: full_title('Новый клиент')) }
    it { should have_selector('label', text: 'Название') }
    it { should have_selector('label', text: 'Телефон') }
    it { should have_selector('label', text: 'E-mail') }
    it { should have_selector('label', text: 'Адрес') }
    it { should have_selector('label', text: 'Контактное лицо') }
    it { should have_selector('label', text: 'Комментарий') }
    
  end
end
