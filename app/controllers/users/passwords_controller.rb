class Users::PasswordsController < ApplicationController
  before_action :authenticated?, only: [:edit]

  def edit
    @user = current_user
  end

  def reset
    @user = current_user
    ConfirmationSender.send_confirmation_to(@user)
    redirect_to new_confirmation_path
  end

  private

  def authenticated?
    render :file => "#{Rails.root}/public/404.html", :status => 404 unless session[:authenticated] = true
  end

end
