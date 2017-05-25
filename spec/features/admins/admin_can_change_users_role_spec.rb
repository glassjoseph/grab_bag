require 'rails_helper'
require 'helpers/admin_helper'

RSpec.feature "Admin can change a user's role" do
  context "As an Admin on admin index page" do
    scenario "Admin can change a user to admin" do
      stub_admin
      user = create(:user)
      visit admin_users_path(@admin)

      within(".#{user.username}") do
        expect(page).to have_content("default")
        expect(page).to have_button("Make Admin")
        click_on("Make Admin")
      end

      visit admin_users_path(@admin)

      within(".#{user.username}") do
        expect(page).to have_content("admin")
        expect(page).to have_button("Make Default")
      end

      expect(User.unscoped.last.role).to eq("admin")
    end

    scenario "Admin can change another admin to default" do
      stub_admin
      user = create(:admin)
      visit admin_users_path(@admin)

      within(".#{user.username}") do
        expect(page).to have_content("admin")
        expect(page).to have_button("Make Default")
        click_on("Make Default")
      end

      visit admin_users_path(@admin)

      within(".#{user.username}") do
        expect(page).to have_content("default")
        expect(page).to have_button("Make Admin")
      end

      expect(User.last.role).to eq("default")
    end
  end
end
