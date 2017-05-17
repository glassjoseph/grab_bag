require 'rails_helper'

RSpec.feature 'Visitors can see a navbar' do
  scenario 'Visitor visits root path' do
    visit root_path

    within '.nav' do
      expect(page).to have_link 'Login'
      expect(page).to have_link 'Public Folders'
      expect(page).to have_link 'Home'
    end
  end
end