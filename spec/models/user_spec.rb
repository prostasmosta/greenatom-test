require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('userexample.com').for(:email) }
    it { should_not allow_value('user@').for(:email) }
    it { should_not allow_value('user@.com').for(:email) }
  end

  describe 'password' do
    it { should have_secure_password }
  end

  describe 'auth_token' do
    it { should have_secure_token(:auth_token) }
  end

  describe 'custom validation' do
    let(:user) { build(:user) }

    it 'is valid with valid passport data' do
      expect(user).to be_valid
    end

    it 'is invalid without email' do
      user.email = nil
      expect(user).to be_invalid
    end

  end

  describe 'methods' do
    let(:user) { create(:user) }

    it 'generates auth token' do
      expect { user.generate_auth_token! }.to(change { user.auth_token })
    end

    it 'returns instance as JSON' do
      json_instance = user.as_json_instance
      expect(json_instance).to be_a(Hash)
      expect(json_instance).not_to have_key(:password_digest)
      expect(json_instance).not_to have_key(:auth_token)
    end

    it 'returns collection as JSON' do
      users = create_list(:user, 3)
      json_collection = User.as_json_collection(users)
      expect(json_collection).to be_an(Array)
      expect(json_collection.first).not_to have_key(:password_digest)
      expect(json_collection.first).not_to have_key(:auth_token)
    end

  end
end
