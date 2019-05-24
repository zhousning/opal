class ExtractCashesController < ApplicationController
  layout "application_mobile"
  before_action :authenticate_user!

  def new
    @extract_cash = ExtractCash.new
    @extract_cashes = current_user.extract_cashes.order("created_at DESC")
  end

  def create
    @extract_cash = ExtractCash.new(extract_cash_params)
    account = current_user.account
    if @extract_cash.coin > 0 && account.coin > @extract_cash.coin
      @extract_cash.user = current_user
      if @extract_cash.save
        account.sub_coin(@extract_cash.coin)
        account.add_freeze_coin(@extract_cash.coin)
        redirect_to new_extract_cash_url
      else
        render :new
      end
    else
      render :new
    end
  end

  private
    def extract_cash_params
      params.require(:extract_cash).permit( :coin, :status)
    end
  
end

