require 'rails_helper'

RSpec.describe Binary do
  attr_reader :text

  before do
    @text = File.read('spec/test.txt')
  end

  context 'Attributes' do
    it 'is invalid without a name' do
      file = Binary.new(folder_id: 1, data: text, extension: 'txt')

      expect(file).to_not be_valid
    end

    it 'is invalid without an extension' do
      file = Binary.new(name: 'test', folder_id: 1, data: text)

      expect(file).to_not be_valid
    end

    it 'is invalid without a folder' do
      file = Binary.new(name: 'sam.pdf', data: text, extension: 'txt')

      expect(file).to_not be_valid
    end

    it 'is invalid without data' do
      file = Binary.new(name: 'sam.pdf', folder_id: 1, extension: 'txt')

      expect(file).to_not be_valid
    end

    it 'is valid with a name, folder, data and extension' do
      user = create :user
      folder = user.home
      file = Binary.new(name: 'sam.pdf',
                        extension: '.pdf',
                        folder: folder,
                        data: text)

      expect(file).to be_valid
    end

    it 'responds to name, extension, folder and data' do
      file = Binary.new

      expect(file).to respond_to :name
      expect(file).to respond_to :extension
      expect(file).to respond_to :folder
      expect(file).to respond_to :data
      expect(file).to respond_to :url
    end
  end

  context 'relationships' do
    it 'has a folder' do
      user = create :user
      folder = user.home

      file = Binary.new(name: 'sam.pdf', folder: folder, data: text)

      expect(file.folder).to be folder
    end
  end

  context 'methods' do
    it 'has a #url' do
      user = create :user
      folder = user.home
      binary = create :binary, folder: folder

      path = folder.url + '/' + binary.name + '.' + binary.extension

      expect(binary.url).to eq path
    end
  end
end
