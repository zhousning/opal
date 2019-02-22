class TreesController < ApplicationController
  layout "application_mobile"

  def index
    @notice = Notice.order('updated_at DESC').first
    if user_signed_in?
      gon.leafs = current_user.leaf.unpick
    else
      gon.leafs = 12 
    end
  end
end

