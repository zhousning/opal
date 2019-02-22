require 'rqrcode_png'

class TasksController < ApplicationController
  layout "application_mobile"
  before_filter :authenticate_user!

  def invite
  end
end
