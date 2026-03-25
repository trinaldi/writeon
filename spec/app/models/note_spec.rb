require 'rails_helper'

describe Note, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_field(:content).of_type(String) }
  it { is_expected.to have_field(:happened_at).of_type(Time) }
  it { is_expected.to be_embedded_in(:journal) }
  it { is_expected.to validate_presence_of(:content) }

  it 'sets happened_at to current time if not provided' do
    freeze_time do
      day = Day.create!(date: Time.zone.today)
      journal = day.create_journal(content: 'start')

      note = journal.notes.create!(content: 'test')

      expect(note.happened_at).to eq(Time.zone.now)
    end
  end
end
