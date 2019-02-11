class TeamsController < ApplicationController
  layout "application_mobile"
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @my_invites = User.find_by_inviter(current_user.number)
  end
end
