require 'rails_helper'

RSpec.describe Mood, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to be_embedded_in(:day) }

  it 'defines mood enum values' do
    expect(described_class.moods.keys).to contain_exactly(
      'very_bad', 'bad', 'neutral', 'good', 'very_good'
    )
  end

  it 'accepts all valid moods' do
    day = create(:day, date: Time.zone.today)

    %i[very_bad bad neutral good very_good].each do |value|
      mood = day.create_mood(attributes_for(:mood, mood: value))
      expect(mood).to be_valid
    end
  end
end
