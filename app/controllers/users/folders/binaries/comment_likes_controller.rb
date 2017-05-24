class Users::Folders::Binaries::CommentLikesController < ApplicationController
  def create
    # binding.pry
    # if params[:binary]
    binary = Binary.find_by(name: params[:binary_name])
    user = binary.folder.owner
    comment = binary.comments.first
    like = comment.likes.new(user: user)
    like.update(like: true)
    redirect_to(binary.url)
    # like = binary.likes.new(user: user)
    # like.update(like: true)
    # redirect_to binary.url
    # else
    # binary = Binary.
    # user
    # comment = find_by params comment id


    # like = binary.comment.likes.new(user: user)
  end
end
