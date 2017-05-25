require 'rails_helper'
require 'helpers/admin_helper'

RSpec.feature "Admin can delete items" do
  context "As an Admin" do
    scenario "admin can delete user's folder" do
      stub_admin
      user = create(:user_with_folders)
      expect(user.home.folders.count).to eq(3)
      visit "/#{user.username}/home"

      expect{ within(first(".folder")) do
                click_on "Delete"
              end
      }.to change{user.home.folders.count}.from(3).to(2)

    expect(current_path).to eq("/#{@admin.username}/home")
    expect(page).to have_content("Successfully Deleted!")
    end

    scenario "admin can delete user's file" do
      stub_admin
      user = create(:user_with_folders)

      expect(user.home.folders.count).to eq(3)
      visit "/#{user.username}/home"

      expect{ within(first(".binary")) do
                click_on "Delete"
              end
      }.to change{user.home.binaries.count}.from(3).to(2)

    expect(current_path).to eq("/#{user.username}/home")
    expect(page).to have_content("Successfully Deleted!")
    end
  end
end
