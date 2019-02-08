class SellsController < ApplicationController
  layout "application_mobile"
  before_action :authenticate_user!
  load_and_authorize_resource

  def new
    @sell = Sell.new
  end

  def create
    @leaf = current_user.leaf
    if params[:sell][:count].to_f <= @leaf.count
      @sell = Sell.new(sell_params)
      @sell.user = current_user
      if @sell.save
        @leaf.sub_count(params[:sell][:count].to_f)
        @leaf.add_freeze_count(params[:sell][:count].to_f)
        redirect_to trades_url 
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

