require 'rails_helper'


RSpec.feature "Admin can see all users" do
  context "As a logged in Admin" do

    before :each do
      @admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
        #make a current_admin method?
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
        # expect(page).to have_css(user1.avatar_url)
        expect(page).to have_content("active")
        expect(page).to have_content("default")
        expect(page).to have_link("Disable")
      end

      within(".#{user2.username}") do
        expect(page).to have_content(user2.username)
        expect(page).to have_content(user2.name)
        expect(page).to have_content(user2.email)
        expect(page).to have_content(user2.phone)
        # expect(page).to have_css(user2.avatar_url)
        expect(page).to have_content("inactive")
        expect(page).to have_content("default")
        expect(page).to have_link("Enable")
      end
    end
  end
end