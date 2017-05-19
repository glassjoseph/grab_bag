class User::FoldersController < ApplicationController

  def show
    @user = current_user
    session[:route] = request.env["PATH_INFO"]
  end

  def index
  end

  def new
    @folder = Folder.new
  end

  def create
    # binding.pry
    username = session[:route].split('/')[1]
    parent_slug= session[:route].split('/')[-1]
    user = User.find_by(username: username)

    parent = Folder.find_by(slug: parent_slug, user_id: user.id)

    new_route = parent.route + "/" + folder_params[:name].parameterize

    folder = Folder.new(folder_params)
    folder.update(user_id: user.id, route: new_route, folder_id: parent.id, slug: folder.slug)
    # require "pry"; binding.pry
    redirect_to folder.url, success: "Folder Successfully Created!"
  end


  private

  def folder_params

    params.require(:folder).permit(:name, :permission)

  end

end
