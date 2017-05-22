class FoldersController < ApplicationController

  def index
    @folders = Folder.where(permission: 'global')
  end

end
