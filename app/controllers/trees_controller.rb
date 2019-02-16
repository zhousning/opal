class TreesController < ApplicationController
  layout "application_mobile"

  def index
    @notice = Notice.order('updated_at DESC').first
  end
end

