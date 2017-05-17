class SessionsController < ApplicationController

  def create
    user = User.find_by(fb_id: request.env['omniauth.auth']['uid'])
    if user.nil?
      redirect_to sign_up_path(info: request.env['omniauth.auth'])
    else
      session[:id] = user.id
      redirect_to home_path(user.id)
    end
  end

end
