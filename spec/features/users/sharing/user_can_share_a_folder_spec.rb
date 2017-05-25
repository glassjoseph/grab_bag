require 'rails_helper'

RSpec.feature 'User can share folders' do
  context 'User is logged in' do
    scenario 'User shares his home folder' do
      user = create :user
      home = user.home
      sam = create :user, email: 'rockstar@hollywood.com'

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit home.url

      click_on 'Share this Folder'

      expect(current_path).to eq users_folder_new_share_path(user.username, home.route)

      fill_in 'users_folder_new_share[email]', with: 'rockstar@hollywood.com'
      click_on 'Send Invite'

      expect(home).to be_in sam.folders_shared_with
    end

    scenario 'User views folders shared with him' do
      user = create :user
      other_user = create :user
      user.folders_shared_with << other_user.home

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit user.home.url

      click_on 'Folders Shared with Me'

      expect(current_path).to eq users_shared_folders_path(user.username)

      within 'tr:first' do
        expect(page).to have_link other_user.home.name
        expect(page).to have_content other_user.username
      end
    end

    scenario 'User visits child folder in a folder shared with him', focus: true do
      user = create :user
      other_user = create :user_with_folders
      binary1 = other_user.home.binaries.first
      folder = other_user.home.folders.first
      binary2 = create :binary, folder: folder

      user.folders_shared_with << other_user.home

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit users_shared_folders_path(user.username)

      click_on other_user.home.name

      expect(current_path).to eq other_user.home.url
      expect(page).to have_link binary1.name

      click_on folder.name

      expect(current_path).to eq folder.url
      expect(page).to have_link binary2.name
    end

    scenario 'User cannot view a shared folders parent' do
      user = create :user
      other_user = create :user_with_folders
      folder = other_user.home.folders.first
      binary = create :binary, folder: folder

      user.folders_shared_with << folder

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit users_shared_folders_path(user.username)

      expect(page).to_not have_link 'Home'
      expect(page).to have_link folder.name

      click_on folder.name

      expect(page).to have_link binary.name

      visit other_user.home.url

      expect(page.status).to eq 404
    end

    scenario 'User can download a binary in a shared folder' do
      # https://stackoverflow.com/questions/29309324/how-to-test-csv-file-download-in-capybara-and-rspec
      user = create :user
      other_user = create :user
      binary = create :binary, folder: other_user.home
      user.folders_shared_with << other_user.home

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit other_user.home.url

      within 'tr:first' do
        click_on 'Download'
      end

      within '.flash' do
        expect(page).to have_content "#{binary.name} Downloaded"
      end
    end

    scenario 'User can upload a file to a shared folder' do
      file_path = '/spec/fixtures/files/test.txt'
      user = create :user
      other_user = create :user
      user.folders_shared_with << other_user.home

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit other_user.home.url

      click_on 'Upload File'

      attach_file('ok', file_path)

      click_on 'Create Binary'

      expect(current_path).to eq Binary.last.url
    end

    scenario 'User can share a shared folder' do
      user = create :user
      home = user.home
      other_user = create :user
      other_user.folders_shared_with << home

      sam = create :user, email: 'rockstar@hollywood.com'

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(other_user)

      visit home.url

      click_on 'Share this Folder'

      within_frame 'share_folder_modal' do
        fill_in 'email', with: 'rockstar@hollywood.com'
        click_on 'Share'
      end

      expect(home).to be_in sam.folders_shared_with
    end
  end
end
