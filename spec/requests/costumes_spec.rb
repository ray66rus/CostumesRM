# encoding: utf-8

require 'spec_helper'

describe "CostumesPages" do

  subject { page }

  let(:user) { FactoryGirl.create(:poweruser) }
  let(:tab_header) { I18n.t('costume.constants.tab_header') }

  describe "list costumes page" do
    before { visit list_costumes_path }
    
    it { should have_selector('title', text: full_title('Костюмы')) }
    it { should have_selector('li.cmgr-tab.cmgr-active', text: tab_header) }
    it { should_not have_selector('li.cmgr-active a', href: list_costumes_path) }
    it { should have_selector('h1', text: 'Список костюмов') }
    it { should have_selector('div', text: 'Название') }
    it { should have_selector('div', text: 'Цена') }
    it { should have_selector('div', text: 'Доступность') }
    it { should have_selector('div', text: 'Комментарий') }
    it { should have_selector('div', text: 'Изображения') }
    it { should have_selector('div', text: 'Части') }
    it { should have_selector('a', text: 'Добавить костюм') }
  end

  describe "add costume page" do
    before do
      sign_in user
      visit add_costume_path
    end

    it { should have_selector('title', text: full_title('Новый костюм')) }
    it { should have_selector('li.cmgr-tab.cmgr-active', text: tab_header) }
    it { should_not have_selector('li.cmgr-active a', href: list_costumes_path) }
    it { should have_selector('h1', text: 'Добавление костюма') }
    it { should have_selector('label', text: 'Название') }
    it { should have_selector('label', text: 'Цена') }
    it { should have_selector('label', text: 'Доступность') }
    it { should have_selector('label', text: 'Комментарий') }
    it { should have_selector('label', text: 'Изображения') }
  end

  describe "edit costume page" do
    let(:costume) { FactoryGirl.create(:costume) }
    before do
      sign_in user
      visit edit_costume_path(costume)
    end
    
    it { should have_selector('title', text: full_title('Изменение костюма')) }
    it { should have_selector('li.cmgr-tab.cmgr-active', text: tab_header) }
    it { should_not have_selector('li.cmgr-active a', href: list_costumes_path) }
    it { should have_selector('h1', text: 'Изменение информации о костюме') }
    it { should have_selector('div', text: 'Название') }
    it { should have_selector('div', text: 'Цена') }
    it { should have_selector('div', text: 'Доступность') }
    it { should have_selector('div', text: 'Комментарий') }
    it { should have_selector('div', text: 'Части') }
    it { should have_selector('div', text: 'Изображения') }
  end

  describe "edit simple costume page" do
    let(:costume) { FactoryGirl.create(:costume, :simple) }
    before do
      sign_in user
      visit edit_costume_path(costume)
    end
    
    it { should_not have_selector('title', text: full_title('Изменение костюма')) }
    it { should have_selector('li.cmgr-tab.cmgr-active', text: tab_header) }
    it { should_not have_selector('li.cmgr-active a', href: list_costumes_path) }
    it { should have_selector('title', text: full_title('Костюмы')) }
  end

end