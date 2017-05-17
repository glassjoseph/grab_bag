require 'rails_helper'

RSpec.feature "Visitor can create an account" do
  context "As a visitor not in database" do

    it "visitor can create an account" do
      Capybara.app = GrabBag::Application
      stub_oauth

      visit '/'

      click_on "Login with Facebook"

      expect(current_path).to eq('/sign_up')

      fill_in "Username", with: 'samistheman'
      fill_in "Phone", with: "5555555555"

      click_on "Create Account"

      expect(current_path).to ("samistheman/home")
      expect(page).to have_content("Account Created!")
    end
  end
end
