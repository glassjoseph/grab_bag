class Users::FoldersController < Users::BaseController
  before_action :folder_authorize, only: [:destroy]

  def show
    user = User.find_by(username: params[:username])

    if @current_folder = current_folder
      session[:folder_id] = @current_folder.id
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  def new
    @folder = Folder.new
  end

  def create
    user = User.find_by(username: params[:username])
    parent_folder = user.owned_folders.find_by(route: params[:route])

    folder = Folder.new(folder_params)

    if folder.update(user_id: parent_folder.owner.id,
                     folder_id: parent_folder.id)
      redirect_to folder.url, success: "Folder Successfully Created!"
    else
      redirect_to parent_folder.url, warning: "Folder already exists."
    end
  end

  def destroy
    user = User.find_by(username: params[:username])
    folder = user.owned_folders.find_by(route: params[:route])
    parent = folder.parent
    folder.destroy
    redirect_to parent.url, success: "#{folder.name} Successfully Deleted!"
  end

private

  def folder_params
    params.require(:folder).permit(:name, :permission)
  end

  def folder_delete_permissions
    folder = current_folder
    current_user.id == folder.owner.id || current_user.admin?
  end

  def folder_authorize
    folder = current_folder
    unless folder_delete_permissions
      redirect_back(fallback_location: folders_path)
       flash[:warning] = "Sorry, you don't have perimission to delete #{folder.name}!"
    end
  end
end
