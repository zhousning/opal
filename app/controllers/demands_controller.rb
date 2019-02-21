class DemandsController < ApplicationController
  layout "application_mobile"
  before_action :authenticate_user!

  def index 
    @demands = current_user.demands.where(:status => Setting.demands.enable).order("created_at DESC") 
    @demand_successes = current_user.demands.where(:status => Setting.demands.disable).order("created_at DESC") 
  end

  def destroy
    @demand = Demand.find(params[:id])
    current_user.account.sub_freeze_coin(@demand.total)
    current_user.account.add_coin(@demand.total)
    @demand.destroy
    redirect_to :action => :index
  end

  def new
    @demand = Demand.new
    @trade = Trade.last
  end

  def create
    @trade = Trade.last
    @demand = Demand.new(demand_params)
    coin = current_user.account.coin
    price = demand_params[:price].to_f
    count = demand_params[:count].to_f
    sum = price*count

    if (price >= @trade.min && price <= @trade.max) && count >=5  
      if coin >= sum
        @demand.total = sum
        @demand.user = current_user
        if @demand.save
          current_user.account.sub_coin(sum)
          current_user.account.add_freeze_coin(sum)
          Consume.create(:category => Setting.consumes.category_purchase_leaf, :coin_cost => sum, :status => Setting.consumes.status_success, :user_id => current_user.id, :demand_id => @demand.id)
          redirect_to trades_path 
        else
          render :new
        end
      else
        redirect_to recharge_accounts_url
      end
    else
      render :new
    end
  end

  private
    def demand_params
      params.require(:demand).permit( :price, :count)
    end
  
end

