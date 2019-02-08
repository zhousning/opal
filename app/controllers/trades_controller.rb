class TradesController < ApplicationController
  layout "application_mobile"

  def index
    @demands = Demand.where(:status => Setting.demands.enable).order("created_at DESC") 
    @sells = Sell.all
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
end
