class LeafsController < ApplicationController
  layout "application_mobile"
  #before_action :authenticate_user!
  #load_and_authorize_resource


  def pick
    leaf = Leaf.find(params[:id])
    unpick = leaf.unpick
    leaf.add_pick(leaf.unpick)

    if unpick != 0
      tree_count = current_user.tree.count
      count = 0.42/6*unpick
      leaf.add_count(count)
    end

    redirect_to mobile_index_trees_path
  end

  def produce_leaf
  end


  def index
    @leafs = Leaf.all
  end

  def show
    @leaf = Leaf.find(params[:id])
  end

  def new
    @leaf = Leaf.new
  end

  def edit
    @leaf = Leaf.find(params[:id])
  end

  def update
    @leaf = Leaf.find(params[:id])
    if @leaf.update(leaf_params)
      redirect_to leaf_path(@leaf) 
    else
      render :edit
    end
  end

  def create
    @leaf = Leaf.new(leaf_params)
    #@leaf.user = current_user
    if @leaf.save
      redirect_to @leaf
    else
      render :new
    end
  end

  def destroy
    @leaf = Leaf.find(params[:id])
    @leaf.destroy
    redirect_to :action => :index
  end

  private
    def leaf_params
      params.require(:leaf).permit( :pick, :unpick, :count, :pick_time)
    end
  
end

