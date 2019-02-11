class TasksController < ApplicationController
  layout "application_mobile"
  before_filter :authenticate_user!

  def invite
    @invite_link = logup_users_url(:inviter=>current_user.number)
  end
end
