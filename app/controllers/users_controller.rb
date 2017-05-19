class UsersController < ApplicationController
  def show

  end

  def edit

  end

  def update
    current_user.update(user_params)
    redirect_to dashboard_path(current_user.username), success: "Profile Updated"
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone, :email)
  end


end
