require 'rails_helper'

RSpec.describe Folder do
  context 'Attributes' do
    attr_reader :user

    before do
      @user = create :user
    end

    it 'is invalid without a name' do
      folder = Folder.new(owner: user, route: 'home/sam', parent: user.home)

      expect(folder).to_not be_valid
    end

    it 'is invalid without an owner' do
      folder = Folder.new(name: 'sam', route: 'home/sam')

      expect(folder).to_not be_valid
    end

    it 'is invalid without a route' do
      folder = Folder.new(name: 'sam', owner: user, parent: user.home)

      expect(folder).to_not be_valid
    end

    it 'is valid with a name, owner and route' do
      folder = Folder.new(name: 'sam', owner: user, route: 'home/sam', parent: user.home)

      expect(folder).to be_valid
    end

    it 'has a default permission of "personal"' do
      folder = Folder.create(name: 'sam', owner: user, route: 'home', parent: user.home)
      expect(folder.permission).to eq 'personal'
    end

    it 'responds to name, owner, permission, route, folders, binaries, parent, children' do
      folder = Folder.create(name: 'sam', owner: user, route: 'home', parent: user.home)

      expect(folder).to respond_to :name
      expect(folder).to respond_to :owner
      expect(folder).to respond_to :permission
      expect(folder).to respond_to :route
      expect(folder).to respond_to :folders
      expect(folder).to respond_to :binaries
      expect(folder).to respond_to :parent
      expect(folder).to respond_to :children
    end
  end

  context 'Relationships' do
    attr_reader :folder, :user

    before do
      @user = create :user
      @folder = user.home
    end

    it 'has many binaries' do
      binary1 = create :binary, folder: folder
      binary2 = create :binary, folder: folder

      expect(binary1).to be_in folder.binaries
      expect(binary2).to be_in folder.binaries
    end

    it 'has many folders' do

      folder1 = create :folder, parent: folder
      folder2 = create :folder, parent: folder

      expect(folder1).to be_in folder.folders
    end

    it 'has a parent' do
      folder1 = create :folder, parent: folder

      expect(folder1.parent).to be folder
    end

    it 'has many children' do
      folder1 = create :folder, parent: folder
      folder2 = create :folder, parent: folder
      binary1 = create :binary, folder: folder
      binary2 = create :binary, folder: folder

      expect(folder1).to be_in folder.children
      expect(folder2).to be_in folder.children
      expect(binary1).to be_in folder.children
      expect(binary2).to be_in folder.children
    end

    it 'has an owner' do
      expect(folder.owner).to eq user
    end
  end
end
