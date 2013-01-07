class UsersController < ApplicationController
  skip_load_resource :only => [:create, :update, :destroy, :index]
  
  def show
  end

  def new
  end
  
  def create
    user_type = params[:user].nil? ? '' : params[:user].delete(:user_type)
    @user = User.new(params[:user])
    @user.user_type = user_type if current_user.admin?
    if @user.save
      sign_in @user
      flash[:success] = I18n.t('user.messages.welcome')
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    user_type = params[:user].nil? ? '' : params[:user].delete(:user_type)
    @user = User.find(params[:id])
    @user.attributes = params[:user]
    @user.user_type = user_type if current_user.admin?
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
    authorize! :view_users_list, User
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = I18n.t('user.messages.user_deleted')
    redirect_to users_url
  end
end
