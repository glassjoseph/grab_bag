require 'rails_helper'

RSpec.describe Binary do
  attr_reader :text

  before do
    @text = File.read('spec/test.txt')
  end

  context 'Attributes' do
    it 'is invalid without a name' do
      file = Binary.new(folder_id: 1, data: text)

      expect(file).to_not be_valid
    end

    it 'is invalid without a content type' do
      file = Binary.new(content_type: '.txt', folder_id: 1, data: text)

      expect(file).to_not be_valid
    end

    it 'is invalid without a folder' do
      file = Binary.new(name: 'sam.pdf', data: text)

      expect(file).to_not be_valid
    end

    it 'is invalid without data' do
      file = Binary.new(name: 'sam.pdf', folder_id: 1)

      expect(file).to_not be_valid
    end

    it 'is valid with a name, folder and data' do
      user = create :user
      folder = user.home
      file = Binary.new(name: 'sam.pdf', content_type: '.pdf', folder: folder, data: text)

      expect(file).to be_valid
    end

    it 'responds to name, content_type, folder and data' do
      file = Binary.new

      expect(file).to respond_to :name
      expect(file).to respond_to :content_type
      expect(file).to respond_to :folder
      expect(file).to respond_to :data
    end
  end

  context 'relationships' do
    it 'has a folder' do
      user = create :user
      folder = user.home

      file = Binary.new(name: 'sam.pdf', folder: folder, data: text)
    end
  end
end
