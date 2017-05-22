class Users::FoldersController < ApplicationController

  def show
    user = User.find_by(username: params[:username])

    if @current_folder = Folder.find_by(route: params[:route], user_id: user.id)
      session[:folder_id] = @current_folder.id
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end


  def new
    @folder = Folder.new
  end

  def create
    parent_folder = Folder.find(session[:folder_id])
    session.delete(:folder_id)

    folder = Folder.new(folder_params)
    if folder.update(user_id: parent_folder.owner.id,
                     folder_id: parent_folder.id)
      redirect_to folder.url, success: "Folder Successfully Created!"
    else
      redirect_to parent_folder.url, warning: "Folder already exists."
    end
  end

  def destroy
    folder = Folder.find(params[:id])
    parent = folder.parent
    folder.destroy
    redirect_to parent.url, warning: "#{folder.name} Successfully Deleted!"
  end

  private

  def folder_params
    params.require(:folder).permit(:name, :permission)
  end

end
