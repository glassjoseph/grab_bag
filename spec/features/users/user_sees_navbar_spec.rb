require 'rails_helper'

RSpec.feature 'User can see a navbar' do
  context 'A user is logged in' do
    attr_reader :user

    before do
      @user = create :user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    scenario 'Navbar from root path' do
      visit landing_page_path

      within '.navbar' do
        expect(page).to have_link 'Grab Bag'
        expect(page).to have_link 'Public Folders'
        expect(page).to have_link 'My Profile'
        expect(page).to have_link 'Logout'
      end
    end

    scenario 'Public folders button' do
      folder1 = create :folder, owner: user, parent: user.home, permission: :root_global
      folder2 = create :folder, owner: user, parent: user.home, permission: :root_global
      folder3 = create :folder, owner: user, parent: user.home

      visit landing_page_path

      click_on 'Public Folders'

      expect(current_path).to eq public_folders_path
      expect(page).to have_link folder1.name
      expect(page).to have_link folder2.name
      expect(page).to_not have_link folder3.name
    end
  end
end
