class CitrinesController < ApplicationController
  layout "application_mobile"
  before_action :authenticate_user!, :except => [:index]

  def index
  end

  def info 
    @citrine = current_user.citrine
    @consumes = @citrine.consumes.order("created_at DESC")
  end

  def exchange
    @citrine = current_user.citrine
    count = @citrine.count
    if count >= Setting.citrines.exchange_max
      current_user.tree.add_count(1)
      @citrine.sub_count(Setting.citrines.exchange_max)
      Consume.create(:category => Setting.consumes.category_exchange_tree, :coin_cost => Setting.citrines.exchange_max, :status => Setting.consumes.status_success, :citrine_id => @citrine.id)
      redirect_to trees_url
    else
      redirect_to citrines_url
    end
  end
end
