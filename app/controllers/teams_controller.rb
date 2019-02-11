class TeamsController < ApplicationController
  layout "application_mobile"
  before_action :authenticate_user!
  #load_and_authorize_resource

  def index
    @childrens = current_user.children
    @members = @childrens 
    my_invites(@childrens)
  end

  def my_invites(users)
    users.each do |u|
      members = u.children
      @members = @members + members.to_a
      my_invites(members)
    end
  end
end
