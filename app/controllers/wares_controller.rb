class WaresController < ApplicationController
  layout "application_control", :except => [:mobile_index, :mobile_show]
  #layout "application_mobile", :only => [:mobile_index, :mobile_show]
  before_action :authenticate_user!, :except => [:mobile_index, :mobile_show]
  load_and_authorize_resource :except => [:mobile_index, :mobile_show]

  def index
    @wares = Ware.all
  end

  def mobile_index
    @wares = Ware.where(:status => Setting.wares.up)
  end

  def show
    @ware = Ware.find(params[:id])
  end

  def mobile_show
    @ware = Ware.find(params[:id])
  end
  
  def new
    @ware = Ware.new
  end

  def down
    @ware = Ware.find(params[:id])
    @ware.down
    redirect_to wares_path
  end

  def up
    @ware = Ware.find(params[:id])
    @ware.up
    redirect_to wares_path
  end

  def edit
    @ware = Ware.find(params[:id])
  end

  def update
    @ware = Ware.find(params[:id])
    if @ware.update(ware_params)
      redirect_to ware_path(@ware) 
    else
      render :edit
    end
  end

  def create
    @ware = Ware.new(ware_params)
    #@ware.user = current_user
    if @ware.save
      redirect_to @ware
    else
      render :new
    end
  end

  def destroy
    @ware = Ware.find(params[:id])
    @ware.destroy
    redirect_to :action => :index
  end

  private
    def ware_params
      params.require(:ware).permit( :title, :price, :citrine_count, :freight, :description, :category, :brand , enclosures_attributes: enclosure_params)
    end
  
    def enclosure_params
      [:id, :file, :_destroy]
    end
  
end

