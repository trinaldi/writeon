require 'rails_helper'

describe Day, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_field(:date).of_type(Date) }
  it { is_expected.to embed_one(:journal) }
  it { is_expected.to embed_one(:mood) }
  it { is_expected.to embed_many(:todos) }
  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_uniqueness_of(:date) }

  it 'does not allow duplicate date' do
    today = Time.zone.today

    create(:day, date: today)

    expect do
      create(:day, date: today)
    end.to raise_error(Mongoid::Errors::Validations, /Date has already been taken/)
  end
end
