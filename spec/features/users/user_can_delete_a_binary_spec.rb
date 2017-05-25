require 'rails_helper'

RSpec.feature do
  context "as a logged in user" do
    it "can delete my own binary from a folder show page" do
      user = create(:user_with_folders)
      binary = user.home.binaries.first
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/#{user.username}/home"
      first('.binaries > tr').click_on "Delete"

      expect(page).to have_content("#{binary.name} Successfully Deleted")
      expect(current_path).to eq("/#{user.username}/home")
    end
    it "can delete my own binary from a binary show page" do
      user = create(:user_with_folders)
      binary = user.home.binaries.first
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit binary.url

      click_on "Delete"

      expect(page).to have_content("#{binary.name} Successfully Deleted")
      expect(current_path).to eq("/#{user.username}/home")
    end
    it "can't delete someone else's binary" do
      user1 = create(:user)
      user2 = create(:user_with_folders)
      user2.home.folders.first.update(permission: 'root_global')
      global_folder = user2.home.folders.first
      global_folder.binaries << create(:binary, folder: global_folder)
      binary = global_folder.binaries.first

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit public_folders_path

      click_on "#{global_folder.name}"

      expect(current_path).to eq(global_folder.url)
      expect(page).to have_content("#{binary.name}")

      click_on 'Delete'

      expect(current_path).to eq(binary.url)
      expect(page).to have_content("#{binary.name}")
    end
  end
end
