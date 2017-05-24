class UsersController < ApplicationController
  before_action :authorize_admin


  def index
    @users = User.all
  end
  #
  # def show
  #
  # end
  #
  # def edit
  #
  # end
  #
  # def update
  #   current_user.update(user_params)
  #   redirect_to users_dashboard_path(current_user.username), success: "Profile Updated"
  # end
  #
  # private
  #
  # def user_params
  #   params.require(:user).permit(:name, :phone, :email)
  # end
end
