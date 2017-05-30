require 'rails_helper'

RSpec.feature "User can create a new folder" do
  context "As a logged in User" do
    it "User can create a folder" do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit user.home.url
      click_on "New Folder"

      expect(current_path).to eq(users_new_folder_path(user.username, user.home.route))

      fill_in "folder[name]", with: "Sweet jams"
      choose "folder_permission_personal"

      click_on "Create"

      expect(page).to have_content("Folder Successfully Created!")
      expect(Folder.last.personal?).to be true

      expect(current_path).to eq(Folder.last.url)
    end
    it "User can create a public folder" do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit user.home.url
      click_on "New Folder"

      expect(current_path).to eq(users_new_folder_path(user.username, user.home.route))

      fill_in "folder[name]", with: "Sweet jams"
      choose "folder_permission_root_global"

      click_on "Create"

      expect(page).to have_content("Folder Successfully Created!")
      expect(Folder.last.root_global?).to be true
      expect(current_path).to eq(Folder.last.url)

      visit public_folders_path
      expect(page).to have_content(Folder.last.name)

    end
  end
end
