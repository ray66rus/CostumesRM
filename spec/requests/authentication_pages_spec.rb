# encoding: utf-8

require 'spec_helper'

describe "Authentication" do
  
  subject { page }
  
  describe "signin page" do
    before { visit signin_path }
    
    it { should have_selector('h1', text: I18n.t('sessions.headers.signin')) }
    it { should have_selector('title', text: I18n.t('sessions.titles.signin')) }
  end

  describe "signin" do
    before { visit signin_path }
    
    describe "with invalid information" do
      before { click_button I18n.t('helpers.submit.session.create') }

      it { should have_selector('title', text: I18n.t('sessions.titles.signin')) }
      it { should have_selector("div.alert.alert-error", text: I18n.t('sessions.messages.invalid_signin'))}
      
      describe "after visiting another page" do
        before { visit signup_path }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }
      
      it { should have_selector('title', text: full_title(I18n.t('user.titles.show'))) }
      
      describe "followed by signout" do
        before { visit signout_path }
        it { should have_selector('input[type="submit"]') }
      end
    end
  end

  describe "authorization" do
    describe "for non-signed-in-user" do
      let(:user) { FactoryGirl.create(:user) }
      
      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in I18n.t("helpers.label.session.email"),    with: user.email
          fill_in I18n.t("helpers.label.session.password"), with: user.password
          click_button I18n.t('helpers.submit.session.create')
        end
        
        describe "after signin in" do
          it "should render the desired protected page" do
            page.should have_selector('title', text: full_title(I18n.t('user.titles.edit')))
          end
        end
      end
      
      describe "in the Users controller" do
        before { visit edit_user_path(user) }
        it { should have_selector('title', text: I18n.t('sessions.titles.signin')) }
      end
      
      describe "submitting the update action" do
        before { put user_path(user) }
        specify { response.should redirect_to(signin_path) }
      end
    end
  end
end
