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
  
  describe "signup" do
    
    before { visit signup_path }
    let (:submit) { I18n.t("helpers.submit.user.create") }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
    
    describe "with valid information" do
      before do
        fill_in I18n.t("helpers.label.user.name"),                    with: "Example User"
        fill_in I18n.t("helpers.label.user.email"),                   with: "user@example.com"
        fill_in I18n.t("helpers.label.user.password"),                with: "foobar"
        fill_in I18n.t("helpers.label.user.password_confirmation"),   with: "foobar"
        select I18n.t("user.constants.user_types.admin"), :from => I18n.t("helpers.label.user.user_type")
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end