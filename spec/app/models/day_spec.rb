require 'rails_helper'

describe Day, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_field(:date).of_type(Date) }
  it { is_expected.to embed_one(:journal) }
  it { is_expected.to embed_one(:mood) }
  it { is_expected.to embed_many(:todos) }
  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_uniqueness_of(:date) }

  it "won't allow dupicate date" do
    today = Time.zone.today

    Day.create!(date: today)
    expect { Day.create!(date: today) }
      .to raise_error(Mongoid::Errors::Validations, /Date has already been taken/)
  end
end
