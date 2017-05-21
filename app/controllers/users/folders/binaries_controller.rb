class Users::Folders::BinariesController < ApplicationController
  def new
  end

  def create
    return if params[:binary].blank?

    @user = current_user
    @folder = @user.home
    @binary = @folder.binaries.new
    @binary.uploaded_file = params[:binary]

    if @binary.save!
      redirect_to landing_page_path, success: "Profile Updated"
    else
      render :new, error: "There was a problem submitting your attachment."
    end
  end

  def show
    user = User.find_by(username: params[:username])
    folder = user.owned_folders.find_by(route: params[:route])

    @binary = Binary.find_by(name: params[:binary_name])

    render 'users/binaries/show.html.erb'
  end
end
