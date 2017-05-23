class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :info, :warning, :danger

  helper_method :current_user
  helper_method :current_folder

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_folder
    return false unless params[:username] && params[:route]

    user = User.find_by(username: params[:username])
    @current_folder = user.owned_folders.find_by(route: params[:route])
  end
end
