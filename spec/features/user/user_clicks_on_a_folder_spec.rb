require 'rails_helper'

RSpec.feature 'User has folders' do
  context 'User is logged in and has a folder' do
    attr_reader :user

    before do
      @user = create :user
      folder = create :folder
      file = create :file
      folder.files << file
      user.folders.first << folder1

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    scenario 'User is in home folder and clicks an existing folder' do
      visit folder_path(user.folders.first)

      click_on folder.name

      expect(current_path).to eq folder_path(folder)

      expect(page).to have_link file.name
    end

    scenario 'User uploads a file to a folder' do
      visit folder_path(folder)

      click_on 'Upload'
      # I don't know how to finish this test

    end
  end
end