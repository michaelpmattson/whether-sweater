require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_confirmation_of(:password) }
    it { should validate_presence_of(:password_confirmation).on(:create) }
  end

  describe '.generate_api_key' do
    it 'returns a random string' do
      expect(User.generate_api_key).to be_a(String)
      expect(User.generate_api_key.length).to eq(22)
    end
  end
end
