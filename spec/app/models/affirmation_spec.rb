require 'rails_helper'

describe Affirmation, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_field(:body).of_type(String) }
  it { is_expected.to have_field(:author).of_type(String) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to belong_to(:user) }

  it 'is invalid without content' do
    affirmation = build(:affirmation, body: nil)
    expect(affirmation).not_to be_valid
  end
end
