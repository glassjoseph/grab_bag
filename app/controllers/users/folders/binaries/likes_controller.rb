class Users::Folders::Binaries::LikesController < ApplicationController
  def create
    binary = Binary.find_by(name: params[:binary_name])
    user = binary.folder.owner
    like = binary.likes.create(user: user)
    redirect_to binary.url
  end
end
