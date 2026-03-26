require 'rails_helper'

describe Note, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_field(:content).of_type(String) }
  it { is_expected.to have_field(:happened_at).of_type(Time) }
  it { is_expected.to be_embedded_in(:journal) }
  it { is_expected.to validate_presence_of(:content) }

  context 'with happened_at behavior' do
    let!(:day) { create(:day, date: Time.zone.today) }
    let!(:journal) { day.create_journal(attributes_for(:journal)) }

    it 'defaults to current time if not provided' do
      freeze_time do
        note = journal.notes.create!(attributes_for(:note).except(:happened_at))
        expect(note.happened_at).to eq(Time.zone.now)
      end
    end
  end
end
