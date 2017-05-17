require 'rails_helper'


RSpec.feature "Visitor can create an account" do
  context "As a visitor not in database" do

    it "visitor can create an account" do
      Capybara.app = GrabBag::Application
      stub_oauth

      visit '/'

      click_on "Login with Facebook"

      expect(current_path).to eq('/sign_up')

      fill_in "Phone:", with: "5555555555"

      click_on "Create Account"

      expect(current_path).to ("dummyuser/home")
      expect(page).to have_content("Account Created!")
    end
  end
end


# As a visitor
# And I do not have a FBID in the database
# If I click login with Facebook
# I log in with Facebook, authorize
# I should be redirected to a page where I enter a phone number
# I click 'Create Account'
# I will be redirected to my home folder
# I see a flash message 'Account Created!"
