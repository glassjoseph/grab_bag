require 'rails_helper'

RSpec.feature 'User can view a binary show page' do
  context 'User is logged in. Binary exists' do
    scenario 'User clicks on a text file from a folder view' do
      user = create :user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      text = create :text_binary

      user.home.binaries << text

      visit folder_path(user.home)

      click_on text.name

      expect(page).to have_link 'Download'

      within '.preview' do
        expect(page.body).to have_content 'This is an example text file.'
      end
    end

    scenario 'User clicks on an image file from a folder view' do
      user = create :user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      image = create :image_binary

      user.home.binaries << image

      visit folder_path(user.home)

      click_on image.name

      expect(page).to have_link 'Download'

      within '.preview' do
        expect(page).to have_css "img[src*='#{image.name}']"
      end
    end
  end
end