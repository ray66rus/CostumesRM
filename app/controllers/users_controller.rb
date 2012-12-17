class UsersController < ApplicationController
  before_filter :admin_user,  only: :destroy
  
  def show
    @user = User.find(params[:id])
 end

  def new
    @user = User.new
  end
  
  def create
    user_type = params[:user].delete :user_type
    @user = User.new(params[:user])
    @user.user_type = user_type if signed_in? && current_user.admin?
    if @user.save
      sign_in @user
      flash[:success] = I18n.t('user.messages.welcome')
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    user_type = params[:user].delete :user_type
    @user = User.find(params[:id])
    @user.attributes = params[:user]
    @user.user_type = user_type if signed_in? && current_user.admin?
    if @user.save
      flash[:success] = I18n.t('user.messages.profile_updated')
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = I18n.t('user.messages.user_deleted')
    redirect_to users_url
  end
  
  private
  
    def admin_user
      redirect_to(signin_path) unless current_user.admin?
    end
end
