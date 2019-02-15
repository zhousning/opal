class UsersController < ApplicationController
  layout "application_control", :except => [:mobile_authc_new, :mobile_authc_create, :mobile_authc_status,   :control]
  layout "application_mobile", :only => [:mobile_authc_new, :mobile_authc_create, :mobile_authc_status,   :control]
  before_action :authenticate_user!, :except => [  :control]
  #load_resource
  #authorize_resource :except => [  :control]

  def index
    @users = User.all.reject{|u| u.email == Setting.admins.email }
  end

  def center
    @user = current_user
  end
  
  def show
    @user = User.find(params[:id])
    @roles = @user.roles.all
  end

  def edit
    @user = User.find(params[:id])
    @roles = Role.all.reject{|role| role.name == Setting.roles.super_admin }
  end

  def update
    @user = User.find(params[:id])
    @user.set_roles(params[:roles])
    if @user.save
      redirect_to @user
    else
      render :edit
    end
  end

  def level
    @citrine_count = current_user.citrine.total
  end

  def control
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to :action => :index
  end
    
  def mobile_authc_new
    @user = current_user
  end

  def mobile_authc_create
    @user = User.find(params[:id])
    @user.pend
    account_password = params[:account_password]
    if account_password.blank?
      render :mobile_authc_new
    end

    if @user.update(user_authc_params)
      @user.account.add_password(account_password)
      redirect_to mobile_authc_status_user_url(@user)
    else
      render :mobile_authc_new
    end
  end

  def mobile_authc_status
    @user = User.find(params[:id])
  end


  private

    def user_params
      params.require(:user).permit(:email)
    end

    def user_authc_params
      params.require(:user).permit(:name, :identity, :alipay)
    end
end
