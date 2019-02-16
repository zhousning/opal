class UsersController < ApplicationController
  layout "application_mobile"
  before_action :authenticate_user!

  def center
    @user = current_user
  end
  
  def level
    @citrine_count = current_user.citrine.total
  end

  def mobile_authc_new
    @user = current_user
  end

  def mobile_authc_create
    account_password = params[:account_password]
    if account_password.blank?
      redirect_to mobile_authc_new_user_url
    else
      @user = current_user 
      @user.pend
      if @user.update(user_authc_params)
        @user.account.add_password(account_password)
        redirect_to mobile_authc_status_user_url(@user)
      else
        render :mobile_authc_new
      end
    end
  end

  def mobile_authc_status
    @user = current_user 
  end


  private

    def user_params
      params.require(:user).permit(:email)
    end

    def user_authc_params
      params.require(:user).permit(:name, :identity, :alipay)
    end
end
