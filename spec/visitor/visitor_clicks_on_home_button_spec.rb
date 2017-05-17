require 'rails_helper'

RSpec.feature "As a visitor", :type => :feature do
  scenario "when I click on the home button in the navbar" do
    visit "/folders"

    click_on 'Home'

    expect(current_path).to eq('/')
  end
end
