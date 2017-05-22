require 'rails_helper'

RSpec.feature "User cannot see another's private folders" do
  context "two users exist, one is logged in" do
    scenario "User cannot see other's private folders" do
      old_user = create(:user_with_folders)
      logged_user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(logged_user)

      visit old_user.home.url

      expect(page.status_code).to eq(404)
      expect(page).to_not have_link(old_user.home.folders.first.name)
    end
  end
end
