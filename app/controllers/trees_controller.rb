class TreesController < ApplicationController
  #layout "application_control"
  #before_action :authenticate_user!
  #load_and_authorize_resource

  def index
    @trees = Tree.all
  end

  def mobile_index
  end

  def show
    @tree = Tree.find(params[:id])
  end

  def new
    @tree = Tree.new
  end

  def edit
    @tree = Tree.find(params[:id])
  end

  def update
    @tree = Tree.find(params[:id])
    if @tree.update(tree_params)
      redirect_to tree_path(@tree) 
    else
      render :edit
    end
  end

  def create
    @tree = Tree.new(tree_params)
    #@tree.user = current_user
    if @tree.save
      redirect_to @tree
    else
      render :new
    end
  end

  def destroy
    @tree = Tree.find(params[:id])
    @tree.destroy
    redirect_to :action => :index
  end

  private
    def tree_params
      params.require(:tree).permit( :name, :count)
    end
  
end

