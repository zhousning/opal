class DemandsController < ApplicationController
  layout "application_mobile"
  before_action :authenticate_user!
  load_and_authorize_resource

  def new
    @demand = Demand.new
  end

  def create
    leafs = current_user
  end

  def create
    coin = current_user.account.coin
    sum = demand_params[:price].to_f*demand_params[:count].to_f
    if coin >= sum
      @demand = Demand.new(demand_params, :status => Setting.demands.enable)
      @demand.user = current_user
      if @demand.save
        current_user.account.sub_coin(sum)
        current_user.account.add_freeze_coin(sum)
        Consume.create(:category => Setting.consumes.category_purchase_leaf, :coin_cost => sum, :status => Setting.consumes.status_success, :user_id => current_user.id)
        redirect_to trades_path 
      else
        render :new
      end
    else
      redirect_to recharge_accounts_url
    end
  end

  private
    def demand_params
      params.require(:demand).permit( :price, :count)
    end
  
end

