class SellsController < ApplicationController
  layout "application_mobile"
  before_action :authenticate_user!

  def index 
    @sells = current_user.sells.where(:status => Setting.sells.enable).order("created_at DESC") 
    @sell_successes = current_user.sells.where(:status => Setting.sells.disable).order("created_at DESC") 
  end

  def destroy
    @sell = Sell.find(params[:id])
    current_user.leaf.add_count(@sell.count)
    current_user.leaf.sub_freeze_count(@sell.count)
    @sell.destroy
    redirect_to :action => :index
  end

  def new
    @sell = Sell.new
    @trade = Trade.last
  end

  def create
    @leaf = current_user.leaf
    @sell = Sell.new(sell_params)
    @trade = Trade.last

    price = sell_params[:price].to_f
    count = sell_params[:count].to_f

    if (price >= @trade.min && price <= @trade.max) && count >=5  
      if count <= @leaf.count
        @sell.user = current_user
        if @sell.save
          @leaf.sub_count(count)
          @leaf.add_freeze_count(count)
          redirect_to trades_url 
        else
          render :new
        end
      else
        render :new
      end
    else
      render :new
    end

  end

  private
    def sell_params
      params.require(:sell).permit( :price, :count)
    end
  
end

