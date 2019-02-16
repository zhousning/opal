class LeafsController < ApplicationController
  layout "application_mobile"
  before_action :authenticate_user!


  def pick
    tree_count = current_user.tree.count
    leaf = current_user.leaf 
    unpick = leaf.unpick*tree_count
    leaf.add_pick(leaf.unpick)

    if unpick != 0
      count = 0.42/6*unpick
      leaf.add_count(count)
    end

    redirect_to trees_path
  end

end

