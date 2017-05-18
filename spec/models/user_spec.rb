require 'rails_helper'

RSpec.describe User do
  context 'validations' do
    it do
      is_expected.to validate_presence_of :username
      is_expected.to validate_presence_of :email
      is_expected.to validate_presence_of :name
      is_expected.to validate_presence_of :fb_id
      is_expected.to validate_presence_of :avatar_url
      is_expected.to validate_presence_of :status
      is_expected.to validate_presence_of :phone
      is_expected.to validate_presence_of :token
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

  # context 'relationships' do
  #   it 'has many orders' do
  #     user = User.create()
  #   end
  # end


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
