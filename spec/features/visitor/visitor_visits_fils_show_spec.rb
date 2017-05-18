require 'rails_helper'

RSpec.feature 'Visitor vists a file show page' do
  context 'a visitor who is not logged in' do
    scenario 'gets a 404 for a private file' do
      user = create(:user)

      folder = create(:folder)
      file = create(:binary, folder: folder)

      visit "/#{user.username}/#{folder.name}/#{file.name}"

      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end
  end
end
