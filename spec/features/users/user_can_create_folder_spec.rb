require 'rails_helper'

RSpec.feature "User can create a new folder" do
  context "As a logged in User" do
    it "User can create a folder" do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit "/#{user.username}/home"
      click_on "New Folder"

      expect(current_path).to eq("/#{user.username}/folder/new")
      fill_in "Folder Name", with: "Sweet jams"
      choose "Public"
      click_on "Create"

      expect(page).to have_content("Folder Successfully Created!")
      expect(Folder.last.public?).to be_true

      # use parameterize for folder-path creation.
      expect(current_path).to eq("/#{user.username}/home/sweet-jams")
    end

    it "user's new folder is private by default" do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/#{user.username}/home"
      click_on "New Folder"

      expect(current_path).to eq("/#{user.username}/folder/new")
      fill_in "Folder Name", with: "Bastion"
      click_on "Create"

      expect(page).to have_content("Folder Successfully Created!")
      expect(Folder.last.private?).to be_true
      expect(current_path).to eq("/#{user.username}/home/folder")
    end
  end
end
