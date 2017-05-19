class Users::FoldersController < ApplicationController

  def show
    current_url = request.env["PATH_INFO"]
    username = current_url.split('/')[1]
    folder_route = current_url.split('/')[2..-1].join('/')
    user = User.find_by(username: username)

    if @current_folder = Folder.find_by(route: folder_route, user_id: user.id)
      session[:folder_id] = @current_folder.id
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  def index
  end

  def new
    @folder = Folder.new
  end

  def create
    parent_folder = Folder.find(session[:folder_id])
    session.delete(:folder_id)
    new_route = parent_folder.route + "/" + folder_params[:name].parameterize

    folder = Folder.new(folder_params)
    if folder.update(user_id: parent_folder.owner.id,
                     route: new_route,
                     folder_id: parent_folder.id)

      redirect_to folder.url, success: "Folder Successfully Created!"
    else
      redirect_to parent_folder.url, warning: "Folder already exists."
    end

  end


  private

  def folder_params
    params.require(:folder).permit(:name, :permission)
  end

end
