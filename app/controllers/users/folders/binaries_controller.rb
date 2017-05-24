class Users::Folders::BinariesController < Users::BaseController
  before_action :set_s3_direct_post, only: [:new, :create]
  before_action :binary_authorize, only: [:destroy]

  def new
    @binary = Binary.new
  end

  def create
    user = User.find_by(username: params[:username])
    folder = user.owned_folders.find_by(route: params[:route])
    binary = Binary.new(binary_params)

    binary_name = get_name
    if binary.update(name: binary_name.first,
                     extension: binary_name.last,
                     folder_id: folder.id
      )
      redirect_to binary.url, success: "File created"
    else
      render :new, error: "There was a problem submitting your attachment."
    end
  end

  def show
    user = User.find_by(username: params[:username])
    folder = user.owned_folders.find_by(route: params[:route])

    @binary = Binary.find_by(name: params[:binary_name])
    @comment = Comment.new

    render 'users/folders/binaries/show.html.erb'
  end

  def destroy
    user = User.find_by(username: params[:username])
    folder = user.owned_folders.find_by(route: params[:route])
    binary = folder.binaries.find_by(name: params[:binary_name])
    parent = binary.folder
    binary.destroy
    redirect_to parent.url, success: "#{binary.name} Successfully Deleted!"
  end
private

  def get_name
    binary_params[:data_url].split('/').last.split('.')
  end

  def binary_params
    params.require(:binary).permit(:data_url)
  end

  def set_s3_direct_post
   @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  end

  def binary_delete_permission
    folder = current_folder
    binary = folder.binaries.find_by(name: params[:binary_name])
    current_user.id == binary.folder.owner.id || current_user.admin?
  end

  def binary_authorize
    folder = current_folder
    binary = folder.binaries.find_by(name: params[:binary_name])
    unless binary_delete_permission
      redirect_to binary.url, warning: "Sorry, you don't have perimission to delete #{binary.name}!"
    end
  end
end
