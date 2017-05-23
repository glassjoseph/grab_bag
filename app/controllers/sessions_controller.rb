class SessionsController < ApplicationController
  def create
    if params[:user] && params[:user][:password]
      regular_user
    else
      facebook_user
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to landing_page_path
  end

  private

  def facebook_user
    if user = User.find_by(fb_id: request.env['omniauth.auth']['uid'])
      session[:user_id] = user.id
      redirect_to folder_path(route: 'home', username: user.username)
    else
      redirect_to sign_up_path(info: request.env['omniauth.auth'])
    end
  end

  def regular_user
    if user = User.find_by(username: params[:user][:username])
      user_exists(user)
    else
      flash[:danger] = 'Invalid Username'
      redirect_to landing_page_path
    end
  end

  def user_exists(user)
    if user.fb_id.nil?
      regular_user_exists(user)
    else
      flash[:danger] = 'Invalid Username'
      redirect_to landing_page_path
    end
  end

  def regular_user_exists(user)
    if user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      flash[:success] = 'Login successful'

      redirect_to folder_path(route: 'home', username: user.username)
    else
      flash[:danger] = 'Wrong Password'

      redirect_to landing_page_path
    end
  end

end
