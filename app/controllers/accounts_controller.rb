class AccountsController < ApplicationController
  layout "application_mobile"
  before_action :authenticate_user!

  def info 
    @account = current_user.account 
    @orders = current_user.orders.where(:state => Setting.orders.paid).order("created_at DESC")
  end

  def recharge
    redirect_to new_order_url
  end

  def edit
    @account = current_user.account 
  end

  def update
    @account = Account.find(params[:id])
    unless params[:account][:password].blank?
      @account.add_password(params[:account][:password])
      redirect_to status_accounts_path
    else
      redirect_to edit_account_path(@account)
    end
  end
  
  private
    def account_params
      params.require(:account).permit( :password)
    end
  
end

