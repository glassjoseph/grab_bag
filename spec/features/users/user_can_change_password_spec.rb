require "rails_helper"

RSpec.feature "User changes their password" do
  context "as a logged in user" do
    it "user can change their profile info" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "#{user.nickname}/dashboard"
      click_on "Change Password"


      expect(page).to have_content("Old Password")
      expect(page).to have_content("New Password")
      expect(page).to have_content("Confirm New Password")

      fill_in "user[old_password]", with: "#{user.password}"
      fill_in "user[password]", with: "new_password"
      fill_in "user[confirm_password]", with: "new_password"

      click_on "Update Password"

      expect(current_path).to eq("#{user.username}/dashboard")
      expect(user.password).to eq("new_password")
    end
  end
end
