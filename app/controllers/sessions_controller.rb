class SessionsController < ApplicationController
  def create
    # Holy ugly action batman
    if params[:user] && params[:user][:password]
      user = User.find_by(username: params[:user][:username])
      if user && user.fb_id.nil? && user.authenticate(params[:user][:password])
        session[:user_id] = user.id
        flash[:success] = 'Login successful'

        redirect_to folder_path(route: 'home', username: user.username)
      else
        flash[:danger] = 'Login failed'

        redirect_to landing_page_path
      end
    else
      user = User.find_by(fb_id: request.env['omniauth.auth']['uid'])
      if user.nil?
        redirect_to sign_up_path(info: request.env['omniauth.auth'])
      else
        session[:user_id] = user.id
        redirect_to folder_path(route: 'home', username: user.username)
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to landing_page_path
  end
end
