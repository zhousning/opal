class TradesController < ApplicationController
  layout "application_mobile"
  before_action :authenticate_user!, :except => [:index]

  def index
    @demands = Demand.where(:status => Setting.demands.enable).order("created_at DESC") 
    @sells = Sell.where(:status => Setting.sells.enable).order("created_at DESC") 
  end

  def betray_new
    @demand = Demand.find(params[:id])
    @leafs = current_user.leaf.count
    @poundage = @demand.price*@demand.count*Setting.systems.poundage
    if @demand.user == current_user || @leafs < @demand.count
      redirect_to trades_url
    end
  end

  def betray_create
    @demand = Demand.find(params[:id])
    total = @demand.price*@demand.count
    final_coin = total*(1-Setting.systems.poundage)

    current_user.leaf.sub_count(@demand.count)
    current_user.account.add_coin(final_coin)

    demand_user = @demand.user
    demand_user.leaf.add_count(@demand.count)
    demand_user.account.sub_freeze_coin(@demand.price*@demand.count)
    @demand.disable
    redirect_to trades_url
  end

  def buy_new
    @sell = Sell.find(params[:id])
    @coin = current_user.account.coin
    total = @sell.price*@sell.count
    if @sell.user == current_user || @coin < total
      redirect_to trades_url
    end
  end

  def buy_create
    @sell = Sell.find(params[:id])
    total = @sell.price*@sell.count

    current_user.account.sub_coin(total)
    current_user.leaf.add_count(@sell.count)
    Consume.create(:category => Setting.consumes.category_purchase_leaf, :coin_cost => total, :status => Setting.consumes.status_success, :user_id => current_user.id)

    sell_user = @sell.user
    sell_user.account.add_coin(total*(1-Setting.systems.poundage))
    sell_user.leaf.sub_freeze_count(@sell.count)
    @sell.disable

    redirect_to trades_url
  end

  def my_demand
    @demands = current_user.demands.where(:status => Setting.demands.enable).order("created_at DESC") 
  end

  def my_sell
    @sells = current_user.sells.where(:status => Setting.sells.enable).order("created_at DESC") 
  end

  def demand_manage
  end

  def sell_manage
  end
end
