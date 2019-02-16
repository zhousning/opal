class NoticesController < ApplicationController
  layout "application_mobile", :only => [:mobile_index, :mobile_show]
  layout "application_control", :except => [:mobile_index, :mobile_show]
  before_action :authenticate_user!
  before_filter :is_super_admin?, :except => [:mobile_index, :mobile_show]
  #load_and_authorize_resource

  def index
    @notices = Notice.all
  end

  def show
    @notice = Notice.find(params[:id])
  end

  def mobile_index
    @notices = Notice.all.order("updated_at DESC")
  end

  def mobile_show
    @notice = Notice.find(params[:id])
  end

  def new
    @notice = Notice.new
  end

  def edit
    @notice = Notice.find(params[:id])
  end

  def update
    @notice = Notice.find(params[:id])
    if @notice.update(notice_params)
      redirect_to notice_path(@notice) 
    else
      render :edit
    end
  end

  def create
    @notice = Notice.new(notice_params)
    if @notice.save
      redirect_to @notice
    else
      render :new
    end
  end

  def destroy
    @notice = Notice.find(params[:id])
    @notice.destroy
    redirect_to :action => :index
  end

  private
    def notice_params
      params.require(:notice).permit( :title, :content)
    end
  
end

