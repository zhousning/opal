class PickRecordsController < ApplicationController
  layout "application_mobile"
  before_action :authenticate_user!

  def index
    @pick_records = current_user.pick_records.order("created_at DESC") 
  end

end

