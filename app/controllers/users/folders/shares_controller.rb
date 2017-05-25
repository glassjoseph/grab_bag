class Users::Folders::SharesController < ApplicationController
  def create
    inviter = User.find_by(username: params[:username])
    folder = inviter.owned_folders.find_by(route: params[:route])

    current_user.folders_shared_with << folder

    redirect_to users_shared_folders_path(current_user.username), success: "You can now view #{inviter.name}'s folder #{folder.name}"
  end
end