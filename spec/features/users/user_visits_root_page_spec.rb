require "rails_helper"

RSpec.feature "User visits the root page" do
  context "as a logged in user" do
    it "user is redirected to user's home page" do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/'

      expect(current_path).to eq("/#{user.username}/home")
    end
  end
end
