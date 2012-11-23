# encoding: utf-8

require 'spec_helper'

describe "User pages" do
  
  subject { page }
  
  describe "signup page" do
    before { visit signup_path }
    
    it { should have_selector('title', text: full_title(I18n.t('user.titles.create'))) }
    it { should have_selector('h1', text: I18n.t('user.headers.create')) }
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    
    it { should have_selector('title', text: full_title(I18n.t('user.titles.show'))) }
    it { should have_selector('h1', text: user.name) }
  end
end