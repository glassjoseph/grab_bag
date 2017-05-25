class Users::Folders::InvitesController < ApplicationController
  def new
    user = User.find_by(username: params[:username])

    @folder = user.owned_folders.find_by(route: params[:route])
  end

  def create
    user = User.find_by(username: params[:username])
    folder = user.owned_folders.find_by(route: params[:route])
    invitee_email = params[:users_folder_new_share_invitation][:email]

    Users::Folders::Invites::InviterMailer.invite(current_user, folder, invitee_email).deliver_now

    redirect_to landing_page_path, success: "Invited #{user.name} to share #{current_folder.name}"
  end

  def show
    @inviter = User.find_by(username: params[:username])
    @folder = @inviter.owned_folders.find_by(route: params[:route])
  end
end