require 'rails_helper'

RSpec.feature do
  context "As an admin" do
    it "I can delete a binary that is not my own" do
      admin = create(:admin)
      user2 = create(:user_with_folders)
      user2.home.folders.first.update(permission: 'root_global')
      global_folder = user2.home.folders.first
      global_folder.binaries << create(:binary, folder: global_folder)
      binary = global_folder.binaries.first

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit public_folders_path

      click_on "#{global_folder.name}"

      expect(current_path).to eq(global_folder.url)
      expect(page).to have_content("#{binary.name}")

      click_on 'Delete'

      expect(current_path).to eq(global_folder.url)
      expect(page).to have_content("#{binary.name} Successfully Deleted!")

    end
  end
end
