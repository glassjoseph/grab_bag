require "rails_helper"

RSpec.feature "User visits their profile page" do
  context "as a logged in user" do
    it "user sees their profile info" do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      click_on "My Profile"

      expect(current_path).to eq("#{user.nickname}/dashboard")
      expect(page).to have_content("Name: #{user.name}")
      expect(page).to have_content("Phone Number: #{user.phone}")
      expect(page).to have_content("Email: #{user.email}")
      expect(page).to have_button("Edit Profile")
      expect(page).to have_button("Change Password")
    end
  end
end



As a user
When I click on 'My Profile'
I expect current route to be ':username/dashboard'
I expect to see my user Name
I expect to see a phone number
I expect to see my email
I expect to see a button that says "Edit Profile"
I expect to see a button that says "Change Password"
