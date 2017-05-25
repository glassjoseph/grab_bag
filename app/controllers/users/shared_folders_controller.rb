class Users::SharedFoldersController < Users::BaseController
  def index
    @folders = current_user.folders_shared_with
  end
end