class SessionsController < ApplicationController
  skip_load_and_authorize_resource
  
  def new
  end
  
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = I18n.t('session.messages.invalid_signin')
      render 'new'
    end
  end
  
  def destroy
    sign_out
    redirect_to signin_url
  end
end
