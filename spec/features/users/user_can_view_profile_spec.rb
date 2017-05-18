require "rails_helper"

RSpec.feature "User visits their profile page" do
  context "as a logged in user" do
    it "user sees their profile info" do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/#{user.username}/home"
      click_on "My Profile"

      expect(current_path).to eq("/#{user.username}/dashboard")

      expect(page).to have_content("Name: #{user.name}")
      expect(page).to have_content("Username: #{user.username}")
      expect(page).to have_content("Phone Number: #{user.phone}")
      expect(page).to have_content("Email: #{user.email}")
      expect(page).to have_button("Edit Profile")
      expect(page).to have_button("Change Password")
    end
  end
end
