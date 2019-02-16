class TreesController < ApplicationController
  layout "application_mobile"
  #before_action :authenticate_user!
  #load_and_authorize_resource

  def index
    @notice = Notice.order('updated_at DESC').first
  end
end

