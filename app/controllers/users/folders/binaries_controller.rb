class Users::Folders::BinariesController < ApplicationController

  def new
  end

  def create
    return if params[:binary].blank?
    @user = current_user
    @folder = @user.home
    @binary = @folder.binaries.new
    @binary.uploaded_file = params[:binary]
    if @binary.save!
        redirect_to landing_page_path, success: "Profile Updated"
    else
        render :new, error: "There was a problem submitting your attachment."
    end
  end

  def show
    @binary = Binary.find(params[:id])
    send_data @binary.data, :name => @binary.filename, :type => @binary.content_type
  end

end
