class Users::PasswordsController < ApplicationController
  before_action :authenticated?, only: [:edit, :update]

  def edit
    @user = current_user
  end

  def reset
    ConfirmationSender.send_confirmation_to(current_user)
    redirect_to new_confirmation_path
  end

  def update
    if passwords_not_empty? && passwords_equal?
      current_user.update(password_params)
      redirect_to users_dashboard_path(current_user.username), success: "Password Updated"
      session[:authenticated] = false
    else
      redirect_to users_password_edit_path(current_user.username), warning: "Error, please try again."
    end
  end

  private

  def authenticated?
    render :file => "#{Rails.root}/public/404.html", :status => 404 unless session[:authenticated]
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def passwords_not_empty?
    params[:user][:password].length > 0 && params[:user][:password_confirmation].length > 0
  end

  def passwords_equal?
    params[:user][:password] == params[:user][:password_confirmation]
  end

end
