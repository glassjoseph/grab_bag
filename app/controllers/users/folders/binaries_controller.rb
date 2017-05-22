class Users::Folders::BinariesController < ApplicationController
  before_action :set_s3_direct_post, only: [:new, :create]

  def new
    @binary = Binary.new
  end

  def create
    user = User.find_by(username: params[:username])
    folder = user.owned_folders.find_by(route: params[:route])
    binary = Binary.new(binary_params)
    if binary.update(name: params["binary"]["data_url"].original_filename.split(".")[0],
                     extension: params["binary"]["data_url"].original_filename.split(".")[1],
                     folder_id: folder.id
      )
      redirect_to binary.url, success: "File created"
    else
      render :new, error: "There was a problem submitting your attachment."
    end
  end

  def show
    user = User.find_by(username: params[:username])
    folder = user.owned_folders.find_by(route: params[:route])

    @binary = Binary.find_by(name: params[:binary_name])
    render 'users/folders/binaries/show.html.erb'
  end

  private

  def binary_params
    params.require(:binary).permit(:data_url)
  end

  def set_s3_direct_post
   @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  end

end
