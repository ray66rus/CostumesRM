# encoding: utf-8

require 'spec_helper'

describe "ClientPages" do

  subject { page }

  let(:user) { FactoryGirl.create(:poweruser) }
  let(:tab_header) { I18n.t('client.constants.tab_header') }
  before { sign_in user }

  describe "add client page" do
    before { visit add_client_path }

    it { should have_selector('title', text: full_title('Новый клиент')) }
    it { should have_selector('li.cmgr-tab.cmgr-active', text: tab_header) }
    it { should_not have_selector('li.cmgr-active a', href: list_clients_path) }
    it { should have_selector('h1', text: 'Добавление клиента') }
    it { should have_selector('label', text: 'Название') }
    it { should have_selector('label', text: 'Телефон') }
    it { should have_selector('label', text: 'E-mail') }
    it { should have_selector('label', text: 'Адрес') }
    it { should have_selector('label', text: 'Контактное лицо') }
    it { should have_selector('label', text: 'Комментарий') }    
  end
  
  describe "list clients page" do
    before { visit list_clients_path }
    
    it { should have_selector('title', text: full_title('Клиенты')) }
    it { should have_selector('li.cmgr-tab.cmgr-active', text: tab_header) }
    it { should_not have_selector('li.cmgr-active a', href: list_clients_path) }
    it { should have_selector('h1', text: 'Список клиентов') }
    it { should have_selector('div', text: 'Название клиента') }
    it { should have_selector('div', text: 'Контактные данные') }
    it { should have_selector('div', text: 'Комментарий') }
    it { should have_selector('div', text: 'История заказов') }
    it { should have_selector('div', text: 'Операции') }
    it { should have_selector('a', text: 'Добавить клиента') }
  end

  describe "edit client page" do
    let(:client) { FactoryGirl.create(:client) }
    before { visit edit_client_path(client) }
    
    it { should have_selector('title', text: full_title('Изменение клиента')) }
    it { should have_selector('li.cmgr-tab.cmgr-active', text: tab_header) }
    it { should_not have_selector('li.cmgr-active a', href: list_clients_path) }
    it { should have_selector('h1', text: 'Изменение данных клиента') }
    it { should have_selector('label', text: 'Название') }
    it { should have_selector('label', text: 'Телефон') }
    it { should have_selector('label', text: 'E-mail') }
    it { should have_selector('label', text: 'Адрес') }
    it { should have_selector('label', text: 'Контактное лицо') }
    it { should have_selector('label', text: 'Комментарий') }
  end
end
