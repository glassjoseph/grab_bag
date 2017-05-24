class Users::Folders::Binaries::LikesController < ApplicationController
  def create
    binary = Binary.find_by(name: params[:binary_name])
    user = binary.folder.owner
    like = binary.likes.new(user: user)
    like.update(like: true)
    # binding.pry
    redirect_to binary.url
  end
end
