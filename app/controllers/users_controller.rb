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
    if account_password.blank? || user_authc_params[:name].blank? || user_authc_params[:identity].blank? || user_authc_params[:alipay].blank?
      redirect_to mobile_authc_new_user_url
    else
      @user = current_user 
      @user.pend
      if @user.update(user_authc_params)
        @user.account.add_password(account_password)
        redirect_to authc_pay
      else
        redirect_to mobile_authc_new_user_url
      end
    end
  end

  def authc_pay
    Alipay::Service.create_direct_pay_by_user_wap_url(
      :out_trade_no      => Time.now.to_i.to_s + "%04d" % [rand(10000)],
      :subject           => "茶源实名认证",
      :total_fee         => 1,
      :return_url        => Rails.application.routes.url_helpers.alipay_return_users_url(:host => Setting.systems.host),
      :notify_url        => Rails.application.routes.url_helpers.alipay_notify_users_url(:host => Setting.systems.host)
    )
  end

  def alipay_return
    callback_params = params.except(*request.path_parameters.keys)
    if callback_params.any? && Alipay::Sign.verify?(callback_params)
      redirect_to  mobile_authc_status_user_url
    else
      redirect_to mobile_authc_new_user_url
    end
  end

  def alipay_notify
    notify_params = params.except(*request.path_parameters.keys)
    if Alipay::Sign.verify?(notify_params) and Alipay::Notify.verify?(notify_params)
      case params[:trade_status]
      when 'TRADE_SUCCESS'
        pass
      when 'TRADE_FINISHED'
        pass
      end

      render :text => 'success'
    else
      render :text => 'error'
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
    
    def pass
      user = current_user 
      user.pass
      user.tree.add_count(1) if user.tree.count == 0 
      user.leaf.enable
      father = user.parent
      if father
        father.citrine.add_count(Setting.awards.ten_citrine)
        if grandpa = father.parent
          grandpa.citrine.add_count(Setting.awards.one_citrine) 
        end
      end
    end

end
