require 'rails_helper'

RSpec.feature "User cannot see other accounts" do
  context "two users exist, one is logged in" do
    attr_reader :other_user

    before do
      @other_user = create(:user_with_folders)
      logged_user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(logged_user)
    end

    scenario "User cannot see other's private folders" do
      visit other_user.home.url

      expect(page.status_code).to eq(404)
      expect(page).to_not have_link(other_user.home.folders.first.name)
    end

    scenario "User cannot see other's binaries in private folders" do
      binary = other_user.home.binaries.first

      visit binary.url

      expect(page.status_code).to eq 404

      expect(page).to_not have_link 'Download'
    end

    scenario "User cannot see other's dashboard" do
      visit users_dashboard_path(other_user.username)

      expect(page.status_code).to eq 404
      expect(page.status_code).to_not have_content "Name: #{other_user.name}"
      expect(page.status_code).to_not have_link 'Edit Profile'
    end

    scenario "User cannot see other's edit page" do
      visit users_dashboard_edit_path(other_user.username)

      expect(page.status_code).to eq 404
      expect(page.status_code).to_not have_css "form[class='edit_user']"
    end
  end
end
