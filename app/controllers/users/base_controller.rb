class Users::BaseController < ApplicationController

  #  before_action :authorize_user



  def authorize_user

    # unless

      # current_folder
        # Folder.find_by(route: "home/pies", user_id: current_user.id

      #User can see if
        #username in route?

        #if they own folder
        #if its public folder
        #if its shared with them

        #if viewing a binary in one of above folders

      render :file => "public/404.html", :status => 404 unless authorized?
  end

  def authorized?
    return true if global_folder?
    return true if owned_folder?
    return true if shared_folder?
    # return true if binary_authorized?
    return false
  end



  def owned_folder?
    current_user.owned_folders.find_by(route: params[:route])
  end

  def global_folder?
    current_folder.global?
  end

  def shared_folder?
    current_user.folders_shared_with.find_by(route: params[:route])
  end

  def binary_authorized
  end


end
