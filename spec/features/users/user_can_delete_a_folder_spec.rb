require 'rails_helper'

RSpec.feature do
  context "as a logged in user" do
    it "can delete my own sub folder from a folder show page if the folder has no contents" do
      user = create(:user_with_folders)
      folder = user.home.folders.first
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/#{user.username}/home"
      first('.folders > tr').click_on "Delete"

      expect(page).to have_content("#{folder.name} Successfully Deleted")
      expect(current_path).to eq("/#{user.username}/home")
    end
    it "can delete my own sub folder from a folder show page when it has a folder in it" do
      user = create(:user)
      home = user.home
      factory_array1 = home.folders << create(:folder, parent: home)
      folder1 = factory_array1.first
      factory_array2 = folder1.folders << create(:folder, parent: folder1)
      folder2 = factory_array2.first

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit home.url
      first('.folders > tr').click_on "Delete"
      expect(page).to have_content("#{folder1.name} Successfully Deleted")
      expect(current_path).to eq(home.url)
    end
    it "can delete my own sub folder from a folder show page when it has a binary in it" do
      user = create(:user)
      home = user.home
      factory_array1 = home.folders << create(:folder, parent: home)
      folder1 = factory_array1.first
      binary = create(:binary, folder: folder1)
      folder1.binaries << binary
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit home.url
      first('.folders > tr').click_on "Delete"
      expect(page).to have_content("#{folder1.name} Successfully Deleted")
      expect(current_path).to eq(home.url)
    end
    it "can't delete someone else's folder" do
      user1 = create(:user)
      user2 = create(:user_with_folders)
      user2.home.folders.first.update(permission: 'root_global')
      global_folder = user2.home.folders.first

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit public_folders_path

      expect(page).to_not have_link("Delete")
    end
  end
end
