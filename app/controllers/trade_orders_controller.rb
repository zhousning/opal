class TradeOrdersController < ApplicationController
  layout "application_mobile"
  before_action :authenticate_user!

  def index
    @trade_orders = current_user.trade_orders 
  end

  def show
    @trade_order = TradeOrder.find(params[:id])
  end

  def new
    @trade_order = TradeOrder.new
    @ware = Ware.find(params[:ware_id])
  end

  def edit
    @trade_order = TradeOrder.find(params[:id])
  end

  def pay_create
    @trade_order = TradeOrder.find(params[:id])
    @trade_order.pay if current_user.account.password == params[:password]
    redirect_to @trade_order
  end
  
  def update
    @trade_order = TradeOrder.find(params[:id])
    if @trade_order.update(trade_order_params)
      redirect_to trade_order_path(@trade_order) 
    else
      render :edit
    end
  end

  def create
    @trade_order = TradeOrder.new(trade_order_params)
    @trade_order.user = current_user
    @ware = Ware.find(params[:ware_id])
    @trade_order.ware = @ware
    @trade_order.price = @ware.price
    if @trade_order.save
      @trade_order.pend
      redirect_to @trade_order
    else
      render :new
    end
  end

  def destroy
    @trade_order = TradeOrder.find(params[:id])
    @trade_order.destroy
    redirect_to :action => :index
  end

  def pending
    @trade_orders = current_user.trade_orders.where(:state => Setting.trade_orders.pending)
  end

  def paid
    @trade_orders = current_user.trade_orders.where(:state => Setting.trade_orders.paid)
  end

  def departed
    @trade_orders = current_user.trade_orders.where(:state => Setting.trade_orders.departed)
  end

  def completed
    @trade_orders = current_user.trade_orders.where(:state => Setting.trade_orders.completed)
  end

  def all
    @trade_orders = current_user.trade_orders 
  end

  private
    def trade_order_params
      params.require(:trade_order).permit( :name, :phone, :address)
    end
  
end

