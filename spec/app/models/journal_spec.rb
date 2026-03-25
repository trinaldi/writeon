require 'rails_helper'

describe Journal, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_field(:content).of_type(String) }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to embed_many(:notes) }
  it { is_expected.to be_embedded_in(:day) }

  it 'is invalid without content' do
    journal = Journal.new(content: nil)

    expect(journal).not_to be_valid
  end
end
