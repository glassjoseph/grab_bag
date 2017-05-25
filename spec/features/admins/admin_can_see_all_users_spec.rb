require 'rails_helper'
require 'helpers/admin_helper'

RSpec.feature "Admin can see all users" do
  context "As a logged in Admin" do

    before :each do
      stub_admin
    end

    scenario "Admin can visit users#index and see all users" do
      user1 = create(:user)
      user2 = create(:inactive_user)

      visit admin_users_path(@admin)

      # expect(current_path).to eq('admin/users')
      within(".#{user1.username}") do
        expect(page).to have_content(user1.username)
        expect(page).to have_content(user1.name)
        expect(page).to have_content(user1.email)
        expect(page).to have_content(user1.phone)
        expect(page).to have_css("img[src*='#{user1.avatar_url}']")
        expect(page).to have_content("active")
        expect(page).to have_content("default")
        expect(page).to have_button("Disable")
      end

      within(".#{user2.username}") do
        expect(page).to have_content(user2.username)
        expect(page).to have_content(user2.name)
        expect(page).to have_content(user2.email)
        expect(page).to have_content(user2.phone)
        expect(page).to have_css("img[src*='#{user2.avatar_url}']")
        expect(page).to have_content("inactive")
        expect(page).to have_content("default")
        expect(page).to have_button("Enable")
      end
    end
  end
end
