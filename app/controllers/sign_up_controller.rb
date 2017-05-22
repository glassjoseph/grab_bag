class SignUpController < ApplicationController
  def new
    @user = User.new
    session[:user_info] = params[:info]
  end

  def create

    if session[:user_info]
      user = User.from_omniauth(session[:user_info])

      session.delete(:user_info)
      user.update(facebook_user_params)
      session[:user_id] = user.id
      redirect_to folder_path(username: user.username, route: 'home'), success: 'Account Created!'
    else
      user = User.new(user_params)
      if user.save
        flash[:success] = "Successfully created new user!"
        session[:user_id] = user.id
        redirect_to folder_path(username: user.username, route: 'home'), success: 'Account Created!'
      else
        render :new
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :phone, :name, :email, :password, :password_confirmation)
  end

  def facebook_user_params
    params.require(:user).permit(:username, :phone)
  end
end
