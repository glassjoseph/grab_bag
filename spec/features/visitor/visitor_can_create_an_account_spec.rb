require 'rails_helper'
require 'mock_auth_helper'

RSpec.feature "Visitor can create an account" do
  context "As a visitor not in database" do
    it "visitor can create an account with FB" do
      stub_oauth

      visit '/'

      click_on "Login with Facebook"

      expect(current_path).to eq('/sign_up')

      fill_in 'user[username]', with: 'samistheman'
      fill_in 'user[phone]', with: "5555555555"

      click_on "Create Account"

      expect(current_path).to eq("/samistheman/home")
      expect(page).to have_content("Account Created!")
    end

    context 'A visitor tries to create an account with valid details' do
      scenario 'Visitor clicks create account from root' do
        visit landing_page_path

        click_on 'Create an Account'

        expect(current_path).to eq(sign_up_path)

        fill_in 'user[username]', with: 'samiam'
        fill_in 'user[password]', with: 'samiam'
        fill_in 'user[password_confirmation]', with: 'samiam'
        fill_in 'user[name]', with: 'Sam L'
        fill_in 'user[email]', with: 'sam@sam.com'
        fill_in 'user[phone]', with: '55555555555'

        click_on 'Create Account'

        expect(current_path).to eq folder_path(User.last.username, User.last.home.route)

        within '.flash' do
          expect(page).to have_content 'Account Created!'
        end
      end
    end
  end
end
