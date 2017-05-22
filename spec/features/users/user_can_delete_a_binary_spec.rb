require 'rails_helper'

RSpec.feature do
  context "as a logged in user" do
    it "can delete my own file from a folder show page" do
      user = create(:user_with_folders)
      binary = user.home.binaries.first
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/#{user.username}/home"
      first('.binaries > tr').click_on "Delete"

      expect(page).to have_content("#{binary.name} Successfully Deleted")
      expect(current_path).to eq("/#{user.username}/home")
    end
  end
end
