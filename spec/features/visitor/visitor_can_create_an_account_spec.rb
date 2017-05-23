require 'rails_helper'
require 'mock_auth_helper'

RSpec.feature "Visitor can create an account" do
  context "As a visitor not in database" do
    it "visitor can create an account" do
      stub_oauth

      visit landing_page_path

      click_on "Login with Facebook"

      expect(current_path).to eq(sign_up_path)

      fill_in 'user[username]', with: 'samistheman'
      fill_in 'user[phone]', with: "5555555555"

      click_on "Create Account"

      expect(current_path).to eq("/samistheman/home")
      expect(page).to have_content("Account Created!")
    end
  end
end
