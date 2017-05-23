require "rails_helper"

RSpec.feature "User edits their profile page" do
  context "as a logged in user" do
    it "user can change their profile info" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit users_dashboard_path(user.username)

      click_on "Edit Profile"

      expect(page).to have_selector("input")

      fill_in "user[name]", with: "Confucius"
      fill_in "user[phone]", with: "9999999999"
      fill_in "user[email]", with: "c@c.com"

      click_on "Update Profile"

      expect(page).to have_content("Profile Updated")
      expect(current_path).to eq("/#{user.username}/dashboard")
      expect(page).to have_content("Name: Confucius")
      expect(page).to have_content("Username: #{user.username}")
      expect(page).to have_content("Phone Number: 9999999999")
      expect(page).to have_content("Email: c@c.com")

    end
  end
end
