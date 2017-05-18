require 'rails_helper'

RSpec.feature 'Visitor can view root path' do
  context 'when she is not logged in nor a registered user' do
    scenario 'she can see the root path with welcome message and login button' do
      visit '/'

      expect(current_path).to eq(landing_page_path)
      expect(page).to have_content('Welcome to Grab Bag!')
      within('.welcome') do
        expect(page).to have_link('Login with Facebook')
      end
    end
  end
end
