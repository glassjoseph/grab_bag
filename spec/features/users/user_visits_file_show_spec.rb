require 'rails_helper'

RSpec.feature 'user visits file show page' do
  context 'with access to a folder with a file in it' do
    scenario 'she can click on the file and see things' do
      user = create(:user)

      stub_oauth

      folder = create(:folder, user: user)
      file = create(:binary, folder: folder)

      visit "/#{user.username}/#{folder.name}"

      click_on "#{file.name}"

      expect(current_path).to eq("/#{user.username}/#{folder.name}/#{file.name}")
      expect(page).to have_button("Download")
      expect(page).to have_field("Comments")
      expect(page).to have_button("Post Comment")
    end
  end
end
