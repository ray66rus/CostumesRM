include ApplicationHelper

def sign_in(user)
  visit signin_path
  fill_in I18n.t("helpers.label.session.email"),    with: user.email
  fill_in I18n.t("helpers.label.session.password"), with: user.password
  click_button I18n.t('helpers.submit.session.create')
  cookies[:remember_token] = user.remember_token
end
