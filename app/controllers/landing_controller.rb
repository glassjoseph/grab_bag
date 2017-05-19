class LandingController < ApplicationController
  def index
    redirect_to "/#{current_user.username}/home" if current_user
  end
end
