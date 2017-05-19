require 'rails_helper'

RSpec.feature "User can create a new folder" do
  context "As a logged in User" do
    it "User can create a folder" do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit "/#{user.username}/home"
      click_on "New Folder"

      expect(current_path).to eq("/#{user.username}/folders/new")
      fill_in "folder[name]", with: "Sweet jams"
      choose "folder_permission_personal"
      click_on "Create"

      expect(page).to have_content("Folder Successfully Created!")
      expect(Folder.last.personal?).to be true

      # use parameterize for folder-path creation.
      expect(current_path).to eq("/#{user.username}/home/sweet-jams")
    end
  end
end
