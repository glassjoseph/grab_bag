class Users::Folders::Binaries::CommentLikesController < ApplicationController
  def create
    binary = Binary.find_by(name: params[:binary_name])
    user = binary.folder.owner
    comment = binary.comments.find_by(id: params[:comment_id])
    like = comment.likes.create(user: user)
    redirect_to(binary.url)
  end
end
