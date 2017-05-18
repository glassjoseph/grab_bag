require 'rails_helper'

RSpec.describe User do
  context 'validations' do
    it do
      is_expected.to validate_presence_of :username
      is_expected.to validate_presence_of :email
      is_expected.to validate_presence_of :name
      is_expected.to validate_presence_of :status
      is_expected.to validate_presence_of :phone
      is_expected.to validate_uniqueness_of(:username).ignoring_case_sensitivity
    end
  end

  context 'attributes' do
    it 'responds to' do
      user = User.new

      expect(user).to respond_to(:username)
      expect(user).to respond_to(:email)
      expect(user).to respond_to(:fb_id)
      expect(user).to respond_to(:name)
      expect(user).to respond_to(:avatar_url)
      expect(user).to respond_to(:phone)
      expect(user).to respond_to(:status)
      expect(user).to respond_to(:token)
    end
  end

  context 'relationships' do
    it "has one home folder" do
      user = create(:user)

      expect(user.home).to be_a(Folder)
      expect(user.home).to be_in(user.owned_folders)
    end

    it 'has many folders_shared_with' do
      user = create(:user)
      folder = user.home
      shared_folder = create :folder, parent: folder
      user.folders_shared_with << shared_folder

      expect(shared_folder).to be_in(user.folders_shared_with)
    end

    it "has_many owned_folders" do
      user = create(:user)
      home = user.home
      folder1 = create :folder, parent: home, owner: user
      folder2 = create :folder, parent: home, owner: user
      folder1.folders << folder2
      home.folders << folder1

      expect(home).to be_in(user.owned_folders)
      expect(folder1).to be_in(user.owned_folders)
      expect(folder2).to be_in(user.owned_folders)
    end
  end


  context 'enums' do
    let(:user) { build :user }

    it 'has a default role of active' do
      expect(user.status).to eq 'active'
    end

    it 'can also be inactive' do
      user.inactive!
      expect(user.status).to eq 'inactive'
    end
  end
end
