class AccountsController < ApplicationController
  layout "application_control"
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @accounts = Account.all
  end

  def show
    @account = Account.find(params[:id])
  end

  def new
    @account = Account.new
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update(account_params)
      redirect_to account_path(@account) 
    else
      render :edit
    end
  end

  def create
    @account = Account.new(account_params)
    #@account.user = current_user
    if @account.save
      redirect_to @account
    else
      render :new
    end
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    redirect_to :action => :index
  end

  def recharge
    redirect_to new_order_url
  end

  private
    def account_params
      params.require(:account).permit( :password)
    end
  
end

