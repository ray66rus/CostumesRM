# encoding: utf-8

require 'spec_helper'

describe "PartsPages" do

  subject { page }
  
  let(:user) { FactoryGirl.create(:poweruser) }
  let(:tab_header) { I18n.t('part.constants.tab_header') }
  before { sign_in user }

  describe "add part page" do
    before { visit add_part_path }

    it { should have_selector('title', text: full_title('Новая часть')) }
    it { should have_selector('li.cmgr-active', text: tab_header) }
    it { should_not have_selector('li.cmgr-active a[href="' + list_parts_path + '"]') }
    it { should have_selector('h1', text: 'Добавление новой части костюма') }
    it { should have_selector('label', text: 'Название') }
    it { should have_selector('label', text: 'Место') }
    it { should have_selector('label', text: 'Цена') }
    it { should have_selector('label', text: 'Комментарий') }
    it { should have_selector('label', text: 'Изображения') }
  end
  
  describe "list parts page" do
    before { visit list_parts_path }
    
    it { should have_selector('title', text: full_title('Части костюмов')) }
    it { should have_selector('li.cmgr-active', text: tab_header) }
    it { should_not have_selector('li.cmgr-active a[href="' + list_parts_path + '"]') }
    it { should have_selector('h1', text: 'Список частей костюмов') }
    it { should have_selector('div', text: 'Название') }
    it { should have_selector('div', text: 'Цена') }
    it { should have_selector('div', text: 'Место') }
    it { should have_selector('div', text: 'Комментарий') }
    it { should have_selector('div', text: 'Изображения') }
    it { should have_selector('a', text: 'Добавить часть костюма') }
  end
  
  describe "edit part page" do
    let(:part) { FactoryGirl.create(:part) }
    before { visit edit_part_path(part) }
    
    it { should have_selector('title', text: full_title('Изменение части костюма')) }
    it { should have_selector('li.cmgr-active', text: tab_header) }
    it { should_not have_selector('li.cmgr-active a[href="' + list_parts_path + '"]') }
    it { should have_selector('h1', text: 'Изменение информации о части костюма') }
    it { should have_selector('div', text: 'Название') }
    it { should have_selector('div', text: 'Цена') }
    it { should have_selector('div', text: 'Место') }
    it { should have_selector('div', text: 'Комментарий') }
    it { should have_selector('label', text: 'Изображения') }
  end
  
end
