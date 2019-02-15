class SharePoolsController < ApplicationController
  layout "application_mobile"

  def show
    @share_pool = SharePool.first
  end

  def current_month
    @share_pool = SharePool.first
  end
end

