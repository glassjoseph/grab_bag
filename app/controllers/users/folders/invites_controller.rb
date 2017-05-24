class Users::Folders::InvitesController < Users::BaseController
  def new
    user = User.find_by(username: params[:username])

    @folder = user.owned_folders.find_by(route: params[:route])
  end

  def create
    byebug
    sharing = params[:users_folder_new_share]

    inviter = current_user
    folder = inviter.owned_folders.find_by(route: params[:route])
    folder = Folder.global.find_by(route: params[:route]) unless folder

    invitee = User.find_by(email: sharing[:email])

    if invitee == inviter
      redirect_back(fallback_location: landing_page_path, danger: "You can't share a folder with yourself.")
    elsif invitee
      invitee.folders_shared_with << folder
      redirect_to folder.url, success: "#{folder.name} shared with #{invitee.name}"
    else
      redirect_back(fallback_location: landing_page_path, danger: "#{sharing[:email]} isn't associated with a user.")
    end
  end
end