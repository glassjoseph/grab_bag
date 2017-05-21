require 'rails_helper'

RSpec.describe Comment do
  attr_reader :comment

  before do
    @comment = Comment.new(text: 'This comment adds to the civil discussion of some topic LOL.')
  end

  context 'Attributes' do
    it 'is invalid without text' do
      comment = Comment.new()

      expect(comment).to_not be_valid
    end

    it 'is valid with a text' do
      expect(comment).to be_valid
    end

    it 'responds to text' do
      expect(comment).to respond_to :text
    end
  end

  context 'relationships' do
    it 'has a binary' do
      user = create(:user)
      folder = user.home
      file = create(:text_binary)
      comment = create(:comment)
      file.comments << comment
      folder.binaries << file
    end
  end
end
