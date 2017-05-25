require 'rails_helper'
require 'helpers/admin_helper'

RSpec.feature "Admin can change a user's status" do
  context "As an Admin on admin index page" do
    scenario "Admin can disable a user" do
      stub_admin
      user = create(:user)
      visit admin_users_path(@admin)

      within(".#{user.username}") do
        expect(page).to have_content("active")
        expect(page).to have_button("Disable")
        click_on("Disable")
      end

      visit admin_users_path(@admin)

      within(".#{user.username}") do
        expect(page).to have_content("inactive")
        expect(page).to have_button("Enable")
      end

      expect(User.unscoped.last.status).to eq("inactive")
    end

    scenario "Admin can disable a user" do
      stub_admin
      user = create(:inactive_user)
      visit admin_users_path(@admin)

      within(".#{user.username}") do
        expect(page).to have_content("inactive")
        expect(page).to have_button("Enable")
        click_on("Enable")
      end

      visit admin_users_path(@admin)

      within(".#{user.username}") do
        expect(page).to have_content("active")
        expect(page).to have_button("Disable")
      end

      expect(User.last.status).to eq("active")
    end
  end
end
