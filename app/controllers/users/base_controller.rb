class Users::BaseController < ApplicationController
  before_action :authorize_user

private

  def authorize_user
    render :file => "public/404.html", :status => 404 unless authorized?
  end

  def authorized?
    return true if folder_authed?
    return true if personal_asset?
    return false
  end

  def folder_authed?
    return false unless current_folder

    return true if shared_folder?
    return true if global_folder?
  end

  def personal_asset?
    current_user.username == params[:username]
  end

  def global_folder?
    current_folder.global?
  end

  def shared_folder?
    user = User.find_by(username: params[:username])
    folder = user.owned_folders.find_by(route: params[:route])
    current_user.folders_shared_with.include? folder
  end
end
