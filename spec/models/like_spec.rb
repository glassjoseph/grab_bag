require 'rails_helper'

describe Like do
  context 'Relationships' do
    it 'belongs_to likeable' do
      like = Like.new

      expect(like).to respond_to(:likeable)
    end

    it 'belongs_to user' do
      like = Like.new

      expect(like).to respond_to(:user)
    end
  end
end
