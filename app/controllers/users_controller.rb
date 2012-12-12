class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
 end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
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
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = I18n.t('user.messages.profile_updated')
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
end
