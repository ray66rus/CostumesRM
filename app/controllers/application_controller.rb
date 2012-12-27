class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  load_and_authorize_resource
  
  rescue_from CanCan::AccessDenied do |exception|
    store_location
    redirect_to signin_url, :notice => exception.message
  end
end
