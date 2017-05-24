class PublicFoldersController < ApplicationController

  def index
    @folders = Folder.where(permission: 'root_global')
  end

end
