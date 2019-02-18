class LeafsController < ApplicationController
  layout "application_mobile"
  before_action :authenticate_user!


  def index
    @count = current_user.leaf.count
  end

  def pick
    tree_count = current_user.tree.count
    leaf = current_user.leaf 
    unpick = leaf.unpick*tree_count

    if unpick != 0
      count = (0.42/6)*unpick
      leaf.add_pick(unpick)
      leaf.add_count(count)
      PickRecord.create!(:number => count, :user_id => current_user.id)
    end

    redirect_to trees_path
  end

end

