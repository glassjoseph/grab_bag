require 'rails_helper'

RSpec.describe Folder do
  context 'Attributes' do
    it 'is invalid without a name' do
      folder = Folder.new(owner_id: 1, route: 'home')

      expect(folder).to_not be_valid
    end

    it 'is invalid without an owner' do
      folder = Folder.new(name: 'sam', route: 'home')

      expect(folder).to_not be_valid
    end

    it 'is invalid without a route' do
      folder = Folder.new(name: 'sam', owner_id: 1)

      expect(folder).to_not be_valid
    end

    it 'is valid with a name, owner and route' do
      folder = Folder.new(name: 'sam', owner_id: 1, route: 'home')

      expect(folder).to be_valid
    end

    it 'has a default permission of "private"' do
      folder = Folder.create(name: 'sam', owner_id: 1, route: 'home')

      expect(folder.permission).to eq 'private'
    end

    it 'responds to name, owner, permission, route, folders, files, parent, children' do
      expect(folder).to respond_to :name
      expect(folder).to respond_to :owner
      expect(folder).to respond_to :permission
      expect(folder).to respond_to :route
      expect(folder).to respond_to :folders
      expect(folder).to respond_to :files
      expect(folder).to respond_to :parent
      expect(folder).to respond_to :children
    end
  end

  context 'Relationships' do
    attr_reader :folder

    before do
      @folder = create :folder
    end

    it 'has many files' do
      file1 = create :file
      file2 = create :file

      folder.files << file1
      folder.files << file2

      expect(file1).to be_in folder.files
      expect(file2).to be_in folder.files
    end

    it 'has many folders' do
      folder1 = create :folder
      folder2 = create :folder

      folder.folders << folder1
      folder.folders << folder2

      expect(folder1).to be_in folder.folders
    end

    it 'has a parent' do
      folder1 = create :folder

      folder.folders << folder1

      expect(folder1.parent).to be folder
    end

    it 'has many children' do
      folder1 = create :folder
      folder2 = create :folder
      file1 = create :file
      file2 = create :file

      folder.folders << folder1
      folder.folders << folder2
      folder.files << file1
      folder.files << file2

      expect(folder1).to be_in folder.children
      expect(folder2).to be_in folder.children
      expect(file1).to be_in folder.children
      expect(file2).to be_in folder.children
    end

    it 'has an owner' do
      user = create :user

      user.folders << folder

      expect(folder.owner).to be user
    end
  end
end