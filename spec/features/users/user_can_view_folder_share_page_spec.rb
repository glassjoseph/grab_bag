require 'rails_helper'

RSpec.feature "User can view folder share page" do
  context "As a logged in User" do
    it "User can view folder's share options" do
      user = create(:user_with_folders)
      folder = user.folders.last
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/#{user.username}/#{folder.route}"
      click_on "Share"

      expect(current_path).to eq("/#{user.username}/#{folder.route}/share")
      expect(page).to have_css("input", :count => 3)
      expect(page).to have_selector("input", :value =>"Public")
      expect(page).to have_selector("input", :value =>"Private")
      expect(page).to have_field("Share With User")
      expect(page).to have_content("Shared With:")

      expect(page).to have_content("Save")
    end
  end
end
