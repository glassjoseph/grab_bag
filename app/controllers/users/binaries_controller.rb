class Users::BinariesController < ApplicationController
  def show
    user = User.find_by(username: params[:username])
    folder = user.owned_folders.find_by(route: params[:route])
    @binary = folder.binaries.find_by(name: params[:binary_name],
                                      extension: params[:format])

    case params[:format]
    when 'jpg'
      send_data @binary.data, type: 'image/jpg', disposition: 'inline'
    when 'txt'
      send_data @binary.data, type: 'text/plain', disposition: 'inline'
    end
  end
end
