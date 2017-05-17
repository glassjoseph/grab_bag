class SignUpController < ApplicationController
  def new
    @user = User.from_omniauth(params[:info])
  end

  def create
    user = User.create(user_params)
    session[:id] = user.id
    redirect_to folder_path(username: user.username, route: 'home'), success: 'Account Created!'
  end

  private

  def user_params
    params.require(:user).permit(:name, :token, :fb_id, :email, :avatar_url, :username, :phone)
  end
end
