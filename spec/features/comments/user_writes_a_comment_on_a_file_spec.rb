# As a user
# With access to a file
# And I go to a file's show page
# And I type a message in the comment textarea
# And I click 'Post Comment'
# Then I expect the current path to be the file's show page
# And I expect the comment to be posted on the page

require 'rails_helper'

RSpec.feature 'A user can leave a comment on a file' do
  context 'when it is her own file' do
    scenario 'she can comment on it' do
      user = create(:user_with_folders)
      binding.pry
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      folder = user.home.folders.first

      visit folder.url

      click_on "#{text.name}"

      expect(current_path).to eq("/#{user.username}/home/#{folder.route}/#{text.name}")
      expect(page).to have_field('Comment')

      fill_in "Comment", with: "This is a comment."
      click_on('Post Comment')

      expect(current_path).to eq("/#{user.username}/home/#{folder.route}/#{text.name}")
      expect(page).to have_content('This is a comment.')
    end
  end

  # context 'when it is a file shared with her' do
  #   scenario 'she can comment on it' do
  #     user1, user2 = create_list(:user)
  #     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  #
  #     folder = create(:folder)
  #     text = create(:text_binary)
  #     folder.binaries << text
  #     user.home.folders << folder
  #
  #     visit "/#{user1.username}/home/#{folder.route}"
  #     click_on 'Share'
  #     fill_in('Share With User'), with: "#{user2.email}"
  #     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  #
  #     visit "/#{user1.username}/home/#{folder.route}"
  #     click_on "#{text.name}"
  #
  #     expect(current_path).to eq("/#{user1.username}/home/#{folder.route}/#{text.name}")
  #     expect(page).to have_field('Comment')
  #
  #     fill_in('Comment'), with: 'This is a comment.'
  #     click_on('Post Comment')
  #
  #     expect(current_path).to eq("/#{user1.username}/home/#{folder.route}/#{text.name}")
  #     expect(page).to have_content('This is a comment.')
  #   end
  # end
  #
  # context 'when it is a public file' do
  #   scenario 'she can comment on it' do
  #     user1, user2 = create_list(:user)
  #     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  #
  #     folder = create(:folder)
  #     text = create(:text_binary)
  #     folder.binaries << text
  #     user.home.folders << folder
  #
  #     visit "/#{user1.username}/home/#{folder.route}"
  #     click_on 'Share'
  #     choose('Public')
  #     click_on('Save')
  #     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  #
  #     visit "/#{user1.username}/home/#{folder.route}"
  #     click_on "#{text.name}"
  #
  #     expect(current_path).to eq("/#{user1.username}/home/#{folder.route}/#{text.name}")
  #     expect(page).to have_field('Comment')
  #
  #     fill_in('Comment'), with: 'This is a comment.'
  #     click_on('Post Comment')
  #
  #     expect(current_path).to eq("/#{user1.username}/home/#{folder.route}/#{text.name}")
  #     expect(page).to have_content('This is a comment.')
  #   end
  # end
end
