require 'rails_helper'

RSpec.describe Comment do

  context 'Attributes' do
    it 'is invalid without text' do
      binary = create(:binary)
      comment = Comment.new(binary: binary)

      expect(comment).to_not be_valid
    end

    it 'is invalid without binary' do
      comment = Comment.new(text: 'This comment adds to the civil discussion of some topic LOL.')

      expect(comment).to_not be_valid
    end

    it 'is valid with a text and binary' do
      binary = create(:binary)
      comment = Comment.new(text: 'This comment adds to the civil discussion of some topic LOL.', binary: binary)

      expect(comment).to be_valid
    end

    it 'responds to text and binary' do
      expect(comment).to respond_to(:text)
      expect(comment).to respond_to(:binary)
    end
  end

  context 'relationships' do
    it 'belongs_to a binary' do
      user = create(:user)
      user.home.binaries << create(:binary, folder: user.home)
      comment = create(:comment)
      user.home.binaries.first.comments << comment

      expect(user.home.binaries.first.comments.first).to eq(comment)
      expect(user.home.binaries.first.comments.first).to be_a(Comment)
    end
  end
end
