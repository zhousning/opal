class UsersController < ApplicationController
  layout "application_control", :except => [:mobile_authc_new, :mobile_authc_create, :mobile_authc_status, :login, :logup, :control]
  layout "application_mobile", :only => [:mobile_authc_new, :mobile_authc_create, :mobile_authc_status, :login, :logup, :control]
  before_action :authenticate_user!, :except => [:login, :logup, :control]
  #load_resource
  #authorize_resource :except => [:login, :logup, :control]

  def index
    @users = User.all.reject{|u| u.email == Setting.admins.email }
  end

  def login
    @signin_user = User.new
  end

  def logup
    @signup_user = User.new
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
    if @user.update(user_authc_params)
      redirect_to mobile_authc_status_user_url(@user)
    else
      render :mobile_authc_new
    end
  end

  def mobile_authc_status
    @user = User.find(params[:id])
  end

  def pass
    @user = User.find(params[:id])
    @user.pass
    @user.tree.add_count(1) if @user.tree.count == 0 
    @user.leaf.enable
    @user.citrine.add_count(Setting.awards.one_citrine)
    unless @user.inviter.blank?
      higher_up = User.find_by_number(@user.inviter)
      if higher_up
        higher_up.citrine.add_count(Setting.awards.ten_citrine)
        higher(higher_up)
      end
    end
    redirect_to :action => :index
  end

  def higher(user)
    unless user.inviter.blank?
      higher_up = User.find_by_number(user.inviter)
      if higher_up
        higher_up.citrine.add_count(Setting.awards.one_citrine)
        higher(higher_up)
      end
    end
  end

  def reject 
    @user = User.find(params[:id])
    @user.reject
    @user.leaf.disable
    redirect_to :action => :index
  end

  private

    def user_params
      params.require(:user).permit(:email)
    end

    def user_authc_params
      params.require(:user).permit(:name, :identity, :alipay)
    end
end
