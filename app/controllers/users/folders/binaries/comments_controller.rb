class Users::Folders::Binaries::CommentsController < ApplicationController
  # def create
  #   @binary = Binary.find_by()
  #   @comment = Comment.new
  # end

  def create
    binary = Binary.find_by(name: params[:binary_name])
    user = binary.folder.owner
    comment = binary.comments.new(comment_params)
    comment.update(user_id: current_user.id)
    redirect_to binary.url
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
