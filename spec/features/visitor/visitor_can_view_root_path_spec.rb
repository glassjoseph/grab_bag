require 'rails_helper'

RSPEC.feature 'Visitor can view root path' do
  context 'when she is not logged in nor a registered user' do
    scenario 'she can see the root path with welcome message and login button' do
      visit '/'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Welcome to Grab Bag!')
      within('.nav') do
        expect(page).to have_button('Login')
      end
    end
  end
end
