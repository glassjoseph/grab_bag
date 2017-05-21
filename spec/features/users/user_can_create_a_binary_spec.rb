require 'rails_helper'

RSpec.feature "User can create a new binary" do
  context "As a logged in User" do
    it "click on upload file and be redirected to correct path" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/#{user.username}/home"
      click_on "Upload File"

      expect(current_path).to eq("/#{user.username}/home/binary_new")
    end

    it "can uplaod a file" do
      user = create(:user)
      file = fixture_file_upload('files/test.txt', 'text/plain')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/#{user.username}/home/binary_new"

      post :upload, upload: file
      response.should be_success 
    end
  end
end
