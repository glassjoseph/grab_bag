class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :info, :warning, :danger

  helper_method :current_user
  helper_method :current_folder
  helper_method :authorize_admin
  helper_method :current_admin?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_folder
    return false unless params[:username] && params[:route]
    user = User.find_by(username: params[:username])

    @current_folder = user.owned_folders.find_by(route: params[:route])
  end

  def current_public_folder
    return false unless params[:route]
    route =  params[:route].split('/')
    username = route.shift
    route = route.join
    decrypted_url = Folder.decrypt(route)

    user = User.find_by(username: username)

    @current_public_folder = user.owned_folders.find_by(route: decrypted_route)
  end

  def current_admin?
    current_user.admin? if current_user
  end

  def authorize_admin
    render :file => "public/404.html", :status => 404 unless current_user.admin?
  end

  private

  def check_route
    route =  params[:route].split('/')
    route.shift
    route = route.join
  end

end
