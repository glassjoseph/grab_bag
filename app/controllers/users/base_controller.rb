class Users::BaseController < ApplicationController
  before_action :authorize_user

private

  def authorize_user
    render :file => "public/404.html", :status => 404 unless authorized?
  end

  def authorized?
    return true if current_admin?
    return true if current_folder && folder_authed?
    return true if personal_asset?

    return false
  end

  def folder_authed?
    return true if shared_folder?
    return true if global_folder?
    return true if ancestor_authed?(current_folder.parent) if current_folder.parent
  end

  def ancestor_authed?(parent)
    return true if current_user.folders_shared_with.include? parent

    ancestor_authed?(parent.parent) if parent.parent
  end

  def personal_asset?
    current_user.username == params[:username]
  end

  def global_folder?
    return true if current_folder.global?
    return true if current_folder.root_global?
  end

  def shared_folder?
    user = User.find_by(username: params[:username])
    folder = user.owned_folders.find_by(route: params[:route])
    current_user.folders_shared_with.include? current_folder
  end
end
