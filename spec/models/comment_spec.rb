require 'rails_helper'

RSpec.describe Comment do

  context 'Attributes' do
    it 'is invalid without text' do
      user = create(:user_with_folders)
      binary = user.home.binaries.first
      comment = Comment.new(binary: binary)

      expect(comment).to_not be_valid
    end

    it 'is invalid without binary' do
      comment = Comment.new(text: 'This comment adds to the civil discussion of some topic LOL.')

      expect(comment).to_not be_valid
    end

    it 'is valid with a text and binary' do
      user = create(:user_with_folders)
      binary = user.home.binaries.first
      comment = Comment.new(text: 'This comment adds to the civil discussion of some topic LOL.', binary: binary, user: user)

      expect(comment).to be_valid
    end

    it 'responds to text and binary and user' do
      comment = Comment.new

      expect(comment).to respond_to(:text)
      expect(comment).to respond_to(:binary)
      expect(comment).to respond_to(:user)
    end
  end

  context 'relationships' do
    it 'belongs_to a binary and user' do
      user = create(:user_with_folders)
      binary = user.home.binaries.first
      user.home.binaries << create(:binary, folder: user.home)
      comment = Comment.create(text: 'This comment adds to the civil discussion of some topic LOL.', binary: binary, user: user)

      expect(user.home.binaries.first.comments.first).to eq(comment)
      expect(user.home.binaries.first.comments.first).to be_a(Comment)
    end
  end

  context 'factory' do
    it 'creates a valid comment' do
      comment = create(:comment)

      expect(comment).to be_valid
    end
  end
end
