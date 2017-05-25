class PublicFoldersController < ApplicationController

  def index
    @folders = Folder.where(permission: 'root_global')
  end

  def show
    if @current_folder = current_public_folder
      session[:folder_id] = @current_folder.id
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

end
