class ConsumesController < ApplicationController
  layout "application_control"
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @consumes = Consume.all
  end

  def show
    @consume = Consume.find(params[:id])
  end

  def new
    @consume = Consume.new
  end

  def edit
    @consume = Consume.find(params[:id])
  end

  def update
    @consume = Consume.find(params[:id])
    if @consume.update(consume_params)
      redirect_to consume_path(@consume) 
    else
      render :edit
    end
  end

  def create
    @consume = Consume.new(consume_params)
    #@consume.user = current_user
    if @consume.save
      redirect_to @consume
    else
      render :new
    end
  end

  def destroy
    @consume = Consume.find(params[:id])
    @consume.destroy
    redirect_to :action => :index
  end

  private
    def consume_params
      params.require(:consume).permit( :number, :category, :coin_cost, :coin_now, :status)
    end
  
end

