class ConfirmationsController < ApplicationController

def new
  @user = current_user
end

def create
  @user = current_user
  if @user.verification_code == params[:verification_code]
    session[:authenticated] = true
    redirect_to users_password_edit_path(current_user.username)
  else
    flash.now[:error] = "Verification code is incorrect."
      render :new
  end
end

end
