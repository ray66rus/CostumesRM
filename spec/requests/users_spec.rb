# encoding: utf-8

require 'spec_helper'

describe "User pages" do
  subject { page }
  
  let(:tab_header) { I18n.t('user.constants.tab_header') }

  describe "signup page" do
    let(:user) { FactoryGirl.create(:poweruser) }
    let(:admin) { FactoryGirl.create(:admin) }
    
    describe "visited as non-admin user" do
      before do
        sign_in user
        get signup_path
      end
      specify { response.should redirect_to(signin_path) }
    end

    describe "visited as admin user" do
      before do
        sign_in admin
        visit signup_path
      end
      it { should have_selector('title', text: full_title(I18n.t('user.titles.create'))) }
      it { should have_selector('h1', text: I18n.t('user.headers.create')) }
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:poweruser) }
    let(:another_user) { FactoryGirl.create(:poweruser) }
    let(:admin) { FactoryGirl.create(:admin) }

    describe "as himself" do
      before do
        sign_in user
        visit user_path(user)
      end
      it { should have_selector('title', text: full_title(I18n.t('user.titles.show'))) }
      it { should have_selector('h1', text: user.name) }
      it { should_not have_selector('li.cmgr-tab.cmgr-active', text: tab_header) }
    end

    describe "as another user" do
      before do
        sign_in another_user
        get user_path(user)
      end
      specify { response.should redirect_to(signin_path) }
    end

    describe "as admin" do
      before do
        sign_in admin
        visit user_path(user)
      end
      it { should have_selector('title', text: full_title(I18n.t('user.titles.show'))) }
      it { should have_selector('h1', text: user.name) }
      it { should have_selector('li.cmgr-tab.cmgr-active', text: tab_header) }
      it { should_not have_selector('li.cmgr-active a', href: users_path) }
    end
  end
  
  describe "signup" do
    let(:admin) { FactoryGirl.create(:admin) }
    let (:submit) { I18n.t("helpers.submit.user.create") }
    before do
      sign_in admin
      visit signup_path
    end

    it { should have_selector('li.cmgr-tab.cmgr-active', text: tab_header) }
    it { should_not have_selector('li.cmgr-active a', href: users_path) }

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
    let(:user) { FactoryGirl.create(:poweruser) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page for user" do
      it { should have_selector('h1', text: I18n.t('user.headers.edit')) }
      it { should have_selector('title', text: full_title(I18n.t('user.titles.edit'))) }
      it { should_not have_selector('li.cmgr-tab.cmgr-active', text: tab_header) }
      it { should_not have_selector('select') }
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
        click_button I18n.t("helpers.submit.user.update")
      end

      it { should have_selector('title', text: full_title(I18n.t('user.titles.show'))) }
      it { should have_selector('h1', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email }
    end

    describe "changing user type" do
      let(:user) { FactoryGirl.create(:poweruser) }

      describe "as admin" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit edit_user_path(user)
        end
        
        it { should have_selector('li.cmgr-tab.cmgr-active', text: tab_header) }
        it { should_not have_selector('li.cmgr-active a', href: users_path) }
          
        specify "should be able to change user type" do
          fill_in I18n.t("helpers.label.user.password"),                with: user.password
          fill_in I18n.t("helpers.label.user.password_confirmation"),   with: user.password
          select I18n.t("user.constants.user_types.user"), :from => I18n.t("helpers.label.user.user_type")
          click_button I18n.t("helpers.submit.user.update")    
          user.reload.user_type.should == 'user'
        end
      end
    end
  end
  
  describe "index" do
    let(:user) { FactoryGirl.create(:admin) }

    before(:each) do
      sign_in user
      visit users_path
    end
    
    it { should have_selector('title', text: full_title(I18n.t('user.titles.list'))) }
    it { should have_selector('h1', text: I18n.t('user.headers.list')) }
    it { should have_selector('li.cmgr-tab.cmgr-active', text: tab_header) }
    it { should_not have_selector('li.cmgr-active a', href: users_path) }

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

        let(:delete_button) { I18n.t('user.buttons.delete') }
        it { should have_link(delete_button, href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link(delete_button) }.to change(User, :count).by(-1);
        end
        it { should_not have_link(delete_button, href: user_path(:admin)) }
      end
    end

    describe "as a non-admin user" do
      let(:user) { FactoryGirl.create(:poweruser) }
      let(:non_admin) { FactoryGirl.create(:poweruser) }

      before do
        sign_in non_admin
        visit users_path
      end

      let(:delete_button) { I18n.t('user.buttons.delete') }     
      it { should_not have_link(delete_button, href: user_path(User.first)) }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(signin_path) }
      end
    end
  end  
end