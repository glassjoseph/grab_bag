require 'rails_helper'

RSpec.feature 'User can see a navbar' do
  context 'A user is logged in' do
    scenario 'A logged in user on root path' do
      user = create :user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      within '.navbar' do
        expect(page).to have_link 'Home'
        expect(page).to have_link 'Public Folders'
        within '.dropdown' do
          expect(page).to have_link user.name
          expect(page).to have_link 'Settings'
          expect(page).to have_link 'Logout'
        end
      end
    end
  end
end