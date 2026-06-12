require 'rails_helper'

describe User, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_field(:email).of_type(String) }
  it { is_expected.to have_field(:password_digest).of_type(String) }
  it { is_expected.to have_many(:days) }
  it { is_expected.to have_many(:affirmations) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_presence_of(:password_digest) }

  it 'does not allow duplicate email' do
    user = create(:user)

    expect do
      create(:user, email: user.email)
    end.to raise_error(Mongoid::Errors::Validations, /Email has already been taken/)
  end

  describe '#generate_auth_token' do
    it 'returns a valid JWT token' do
      user = create(:user)
      token = user.generate_auth_token

      payload = JWT.decode(token, Rails.application.secret_key_base).first

      expect(payload['user_id']).to eq(user.id.to_s)
    end

    it 'sets expiration to 24 hours from now' do
      user = create(:user)
      token = user.generate_auth_token

      payload = JWT.decode(token, Rails.application.secret_key_base).first

      expect(payload['exp']).to be_within(5).of(24.hours.from_now.to_i)
    end
  end
end
