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
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }
    
    describe "page" do
      it { should have_selector('h1', text: I18n.t('user.headers.edit')) }
      it { should have_selector('title', text: full_title(I18n.t('user.titles.edit'))) }
    end

    describe "with invalid information" do
      before { click_button I18n.t('helpers.submit.user.update') }
      
      it { should have_selector('div.alert.alert-error') }
    end
    
    describe "with valid information" do
      let(:new_name) { "New name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in I18n.t("helpers.label.user.name"),                    with: new_name
        fill_in I18n.t("helpers.label.user.email"),                   with: new_email
        fill_in I18n.t("helpers.label.user.password"),                with: user.password
        fill_in I18n.t("helpers.label.user.password_confirmation"),   with: user.password
        select I18n.t("user.constants.user_types.poweruser"), :from => I18n.t("helpers.label.user.user_type")
        click_button I18n.t("helpers.submit.user.update")
      end
      
      it { should have_selector('title', text: full_title(I18n.t('user.titles.show'))) }
      it { should have_selector('h1', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email }
      specify { user.reload.email.should_not == 'poweruser' }
    end

    describe "changing user type" do
      let(:user) { FactoryGirl.create(:poweruser) }
      
      describe "as admin" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit edit_user_path(user)
          fill_in I18n.t("helpers.label.user.password"),                with: user.password
          fill_in I18n.t("helpers.label.user.password_confirmation"),   with: user.password
          select I18n.t("user.constants.user_types.user"), :from => I18n.t("helpers.label.user.user_type")
          click_button I18n.t("helpers.submit.user.update")
        end
      
        specify { user.reload.user_type.should == 'user' }
      end

      describe "as user" do
        let(:poweruser) { FactoryGirl.create(:poweruser) }
        before do
          sign_in poweruser
          visit edit_user_path(user)
          fill_in I18n.t("helpers.label.user.password"),                with: user.password
          fill_in I18n.t("helpers.label.user.password_confirmation"),   with: user.password
          select I18n.t("user.constants.user_types.admin"), :from => I18n.t("helpers.label.user.user_type")
          click_button I18n.t("helpers.submit.user.update")
        end
      
        specify { user.reload.user_type.should_not == 'admin' }
      end
    end
  end
  
  describe "index" do
    let(:user) { FactoryGirl.create(:poweruser) }
    
    before(:each) do
      sign_in user
      visit users_path
    end
    
    it { should have_selector('title', text: full_title(I18n.t('user.titles.list'))) }
    it { should have_selector('h1', text: I18n.t('user.headers.list')) }
    
    describe "pagination" do  
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }
      
      it { should have_selector('div.pagination') }
      
      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end
    
    describe "delete link" do
      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end
        
        let(:delete) { I18n.t('user.buttons.delete') }
        it { should have_link(delete, href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link(delete) }.to change(User, :count).by(-1);
        end
        it { should_not have_link(delete, href: user_path(:admin)) }
      end
    end
    
    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:poweruser) }
      
      before { sign_in non_admin }
     
      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(signin_path) }
      end
    end
  end  
end