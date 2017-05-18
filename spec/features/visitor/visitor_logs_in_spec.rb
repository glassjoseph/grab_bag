require 'rails_helper'
require 'mock_auth_helper'

feature 'log_in' do
  context 'Visitor already has an account' do
    it 'and they log in' do
      user = User.create!(fb_id: 10103559484486366,
                          username: 'dummyaccount',
                          email: ENV['facebook_email'],
                          phone: '5555555555',
                          token: ENV['facebook_token'],
                          avatar_url: "http://graph.facebook.com/v2.6/10103559484486366/picture",
                          name: ENV['facebook_name'])

      stub_oauth

      visit '/'
      within '.welcome' do
        click_on 'Login'
      end

      expect(current_path).to eq("/#{user.username}/home")
      expect(page).to have_content "dummyaccount"
      expect(page).to have_link "Logout"
      expect(page).to_not have_link "Login"
    end
  end
end
