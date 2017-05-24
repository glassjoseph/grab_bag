require 'rails_helper'

RSpec.feature 'A user can like things' do
  context 'when she sees a file' do
    scenario 'she can like it' do
      user = create(:user)
      folder = user.home
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      binary = create(:text_binary, folder: folder)

      visit folder.url
      click_on binary.name

      expect(current_path).to eq(binary.url)

      click_on("Like File")

      expect(current_path).to eq(binary.url)
      expect(page).to have_content("Liked File (1)")
    end
  end

  # context 'when she sees a comment' do
  #   scenario 'she can like it' do
  #     user = create(:user)
  #     folder = user.home
  #     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  #     binary = create(:text_binary, folder: folder)
  #
  #     visit folder.url
  #     click_on binary.name
  #
  #     fill_in "comment[text]", with: "This is a comment."
  #     click_on('Post Comment')
  #
  #     click_on("Like Comment")
  #
  #     expect(current_path).to eq(binary.url)
  #     expect(page).to have_content("Liked Comment (1)")
  #   end
  # end
end
