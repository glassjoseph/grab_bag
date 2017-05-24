class UsersController < ApplicationController
  before_action :authorize_admin

  def index
    @users = User.order(:name)
  end

  def update
    user = User.find(params[:user_id])
    user.update(user_params)
    redirect_to admin_users_path
  end

  private
    def user_params
      params.require(:user).permit(:role, :status)
    end
end
