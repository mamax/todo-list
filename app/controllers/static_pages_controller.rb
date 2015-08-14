class StaticPagesController < ApplicationController
  before_action :signed_in_user, only: [:home]

  def home
    @user = current_user
    @projects = @user.projects
  end

end
