class TeamsController < ApplicationController
  layout "application_mobile"
  before_action :authenticate_user!

  def index
    @childrens = current_user.children.where(:status => Setting.users.passed)
    @members = @childrens 
    my_invites(@childrens)
  end

  def my_invites(users)
    users.each do |u|
      members = u.children.where(:status => Setting.users.passed)
      @members = @members + members.to_a
      my_invites(members)
    end
  end
end
