class SellsController < ApplicationController
  layout "application_control"
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @sells = Sell.all
  end

  def show
    @sell = Sell.find(params[:id])
  end

  def new
    @sell = Sell.new
  end

  def edit
    @sell = Sell.find(params[:id])
  end

  def update
    @sell = Sell.find(params[:id])
    if @sell.update(sell_params)
      redirect_to sell_path(@sell) 
    else
      render :edit
    end
  end

  def create
    @sell = Sell.new(sell_params)
    #@sell.user = current_user
    if @sell.save
      redirect_to @sell
    else
      render :new
    end
  end

  def destroy
    @sell = Sell.find(params[:id])
    @sell.destroy
    redirect_to :action => :index
  end

  private
    def sell_params
      params.require(:sell).permit( :price, :count)
    end
  
end

