require 'rails_helper'

RSpec.feature 'User can see a navbar' do
  context 'A user is logged in' do
    attr_reader :user

    before do
      @user = create :user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    scenario 'Navbar from root path' do
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

    scenario 'Public folders button' do
      folder1 = create :folder, status: :public
      folder2 = create :folder, status: :public
      folder3 = create :folder

      visit root_path

      click_on 'Public Folders'

      expect(current_path).to eq folders_path

      expect(page).to have_link folder1.name
      expect(page).to have_link folder2.name
      expect(page).to_not have_link folder3.name
    end
  end
end