# encoding: utf-8

require 'spec_helper'

describe "CostumesPages" do

  subject { page }

  describe "add costume page" do
    before { visit add_costume_path }

    it { should have_selector('title', text: full_title('Новый костюм')) }
    it { should have_selector('h1', text: 'Добавление костюма') }
    it { should have_selector('label', text: 'Название') }
    it { should have_selector('label', text: 'Цена') }
    it { should have_selector('label', text: 'Доступность') }
    it { should have_selector('label', text: 'Комментарий') }
    it { should have_selector('label', text: 'Изображения') }
  end

  describe "list costumes page" do
    before { visit list_costumes_path }
    
    it { should have_selector('title', text: full_title('Костюмы')) }
    it { should have_selector('h1', text: 'Список костюмов') }
    it { should have_selector('div', text: 'Название') }
    it { should have_selector('div', text: 'Цена') }
    it { should have_selector('div', text: 'Доступность') }
    it { should have_selector('div', text: 'Комментарий') }
    it { should have_selector('div', text: 'Изображения') }
    it { should have_selector('a', text: 'Добавить костюм') }
  end

  describe "edit costume page" do
    let(:costume) { FactoryGirl.create(:costume) }
    before { visit edit_costume_path(costume) }
    
    it { should have_selector('title', text: full_title('Изменение костюма')) }
    it { should have_selector('h1', text: 'Изменение информации о костюме') }
    it { should have_selector('div', text: 'Название') }
    it { should have_selector('div', text: 'Цена') }
    it { should have_selector('div', text: 'Доступность') }
    it { should have_selector('div', text: 'Комментарий') }
    it { should have_selector('div', text: 'Изображения') }
  end

  describe "edit simple costume page" do
    let(:costume) { FactoryGirl.create(:costume, :simple) }
    before { visit edit_costume_path(costume) }
    
    it { should_not have_selector('title', text: full_title('Изменение костюма')) }
    it { should have_selector('title', text: full_title('Костюмы')) }
  end

end