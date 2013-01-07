class UsersController < ApplicationController
  PAGE_SIZE = 30
  
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
      flash[:success] = I18n.t('user.messages.welcome')
      if current_user.admin?
        last_page = User.count / PAGE_SIZE
        last_page += 1 if last_page * PAGE_SIZE < User.count
        redirect_to action: :index, page: last_page
      else
        redirect_to @user
      end
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
      if current_user.admin?
        record_number = User.where("id<=" + @user.id.to_s).count
        current_page = record_number / PAGE_SIZE
        current_page += 1 if current_page * PAGE_SIZE < record_number
        redirect_to action: :index, page: current_page
      else
        sign_in @user
        redirect_to @user
      end
    else
      render 'edit'
    end
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: PAGE_SIZE)
    authorize! :view_users_list, User
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = I18n.t('user.messages.user_deleted')
    redirect_to users_url
  end
end
