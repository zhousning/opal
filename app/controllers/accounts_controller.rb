class AccountsController < ApplicationController
  layout "application_mobile"
  before_action :authenticate_user!
  load_and_authorize_resource

  def info 
    @account = current_user.account 
    @orders = current_user.orders.where(:state => Setting.orders.paid).order("created_at DESC")
  end

  def recharge
    redirect_to new_order_url
  end

  private
    def account_params
      params.require(:account).permit( :password)
    end
  
end

