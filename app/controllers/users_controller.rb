class UsersController < ApplicationController
  before_action :authorize_admin

  def index
    @users = User.unscoped.order(:name).paginate(:page => params[:page], :per_page => 20)
  end

  def update
    user = User.unscoped.find(params[:user_id])
    user.update(user_params) if params[:user][:role]
    user.disable if params[:user][:status] == "inactive"
    user.enable if params[:user][:status] == "active"
    redirect_to admin_users_path
  end

  private
    def user_params
      params.require(:user).permit(:role, :status)
    end
end
