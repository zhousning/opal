class TradeOrdersController < ApplicationController
  layout "application_mobile"
  before_action :authenticate_user!

  def index
    @trade_orders = current_user.trade_orders 
  end

  def show
    @trade_order = current_user.trade_orders.find(params[:id])
  end

  def new
    @trade_order = TradeOrder.new
    @ware = Ware.find(params[:ware_id])
  end

  def edit
    @trade_order = current_user.trade_orders.find(params[:id])
  end

  def pay_create
    @trade_order = TradeOrder.find(params[:id])
    if current_user.account.password == convert_to_md5(params[:password])
      @trade_order.pay 
      Consume.create(:category => Setting.consumes.category_buy_ware, :coin_cost => @trade_order.price, :status => Setting.consumes.status_success, :user_id => current_user.id, :trade_order_id => @trade_order.id)
    end
    redirect_to @trade_order
  end
  
  def update
    @trade_order = current_user.trade_orders.find(params[:id])
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

  def confirm
    @trade_order = current_user.trade_orders.find(params[:id])
    @trade_order.complete
    redirect_to completed_trade_orders_url
  end

  def cancel
    @trade_order = current_user.trade_orders.find(params[:id])
    @trade_order.cancel
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

