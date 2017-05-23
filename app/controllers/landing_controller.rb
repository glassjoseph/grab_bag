class LandingController < ApplicationController

  def index
    @user = User.new
    redirect_to "/#{current_user.username}/home" if current_user
  end
end
