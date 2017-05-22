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
  end
end
