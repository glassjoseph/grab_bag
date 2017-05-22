require 'rails_helper'

RSpec.feature 'User can view a binary show page' do
  context 'User is logged in. Binary exists' do
    attr_reader :user, :folder

    before do
      @user = create :user
      @folder = user.home
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    xscenario 'User clicks a binary from a folder view' do
      binary = create :binary, folder: folder

      visit folder.url

      click_on binary.name

      expect(current_path).to eq binary.url
    end

    scenario 'User clicks on a text file from a folder view' do
      text = create :text_binary, folder: folder

      visit text.url
      
      expect(page).to have_link 'Download'

      within '.preview' do
        expect(page.body).to have_content 'This is an example text file.'
      end
    end

    scenario 'User clicks on an image file from a folder view' do
      image = create :image_binary, folder: folder

      visit image.url

      expect(page).to have_link 'Download'

      within '.preview' do
        expect(page).to have_css "img[src*='#{image.name}']"
      end
    end

    scenario 'User clicks on an unknown data type from folder view' do
      unknown = create :unknown_content_type_binary, folder: folder

      visit unknown.url

      expect(page).to have_link 'Download'

      within '.preview' do
        expect(page.body).to have_content "I can't display a preview of that data type."
      end
    end
  end
end
