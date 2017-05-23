class SignUpController < ApplicationController
  def new
    @user = User.new
    session[:user_info] = params[:info]
  end

  def create
    user = User.from_omniauth(session[:user_info])
    user.update(user_params)
    session[:user_id] = user.id

    redirect_to user.home.url, success: 'Account Created!'
  end

private

  def user_params
    params.require(:user).permit(:username, :phone)
  end
end
