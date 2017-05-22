class SessionsController < ApplicationController

  def create
    user = User.find_by(fb_id: request.env['omniauth.auth']['uid'])

    if user.nil?
      redirect_to sign_up_path(info: request.env['omniauth.auth'])
    else
      session[:user_id] = user.id
      redirect_to folder_path(route: 'home', username: user.username)
    end
  end
end
