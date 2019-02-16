class LeafsController < ApplicationController
  layout "application_mobile"
  before_action :authenticate_user!


  def pick
    leaf = current_user.leaf 
    unpick = leaf.unpick
    leaf.add_pick(leaf.unpick)

    if unpick != 0
      tree_count = current_user.tree.count
      count = 0.42/6*unpick
      leaf.add_count(count)
    end

    redirect_to trees_path
  end

end

