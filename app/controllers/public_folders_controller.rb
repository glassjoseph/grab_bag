class PublicFoldersController < ApplicationController

  def index
    @folders = Folder.where(permission: 'root_global')
  end

  def show
    
  end

end
