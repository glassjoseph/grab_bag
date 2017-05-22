class SignUpController < ApplicationController
  def new
    if params[:info]
      @user = User.new(fb_id: params[:info][:uid])
      session[:user_info] = params[:info]
    else
      @user = User.new
    end
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
        flash.now[:danger] = "Account Creation Failed"
        @user = User.new
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
