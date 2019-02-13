class ExtractCashesController < ApplicationController
  layout "application_mobile"
  before_action :authenticate_user!

  def index
    @extract_cashes = current_user.extract_cashes.order("created_at DESC")
  end

  def new
    @extract_cash = ExtractCash.new
  end

  def create
    @extract_cash = ExtractCash.new(extract_cash_params)
    if @extract_cash.coin > 0 && current_user.account.coin >= @extract_cash.coin
      @extract_cash.user = current_user
      if @extract_cash.save
        redirect_to extract_cashes_url
      else
        render :new
      end
    else
      render :new
    end
  end

  def destroy
    @extract_cash = ExtractCash.find(params[:id])
    @extract_cash.destroy
    redirect_to :action => :index
  end

  private
    def extract_cash_params
      params.require(:extract_cash).permit( :coin, :status)
    end
  
end

