require 'rails_helper'

RSpec.feature 'Visitors can see a navbar' do
  scenario 'Visitor visits root path' do
    visit root_path

    within '.navbar' do
      expect(page).to have_link 'Login With Facebook'
      expect(page).to have_link 'Public Folders'
      expect(page).to have_link 'Grab Bag'
    end
  end
end
