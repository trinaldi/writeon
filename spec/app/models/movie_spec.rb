require 'rails_helper'

RSpec.describe Movie, type: :model do
  it { is_expected.to have_field(:title).of_type(String) }
  it { is_expected.to have_field(:year).of_type(Integer) }
  it { is_expected.to have_field(:rating).of_type(Integer) }
  it { is_expected.to have_field(:plot).of_type(String) }
  it { is_expected.to have_field(:review).of_type(String) }
  it { is_expected.to have_field(:watched_at).of_type(DateTime) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:year) }
  it { is_expected.to validate_presence_of(:rating) }
  it { is_expected.to validate_presence_of(:watched_at) }
  it { is_expected.to be_embedded_in(:day) }

  it 'sets watched_at to day date if not provided' do
    freeze_time do
      date = Date.new(2026, 3, 25)
      day = create(:day, date: date)

      movie = day.movies.create!(title: 'Test', year: date.year, rating: 5)

      expect(movie.watched_at.to_date).to eq(date)
    end
  end

  it 'overrides watched_at if provided' do
    date = Date.new(2026, 3, 25)
    day = create(:day, date: date)
    custom_date = DateTime.new(2020, 1, 1)

    movie = day.movies.create!(
      attributes_for(:movie, watched_at: custom_date, year: date.year)
    )

    expect(movie.watched_at).to eq(custom_date)
  end

  it 'allows rating between 1 and 5' do
    day = create(:day)

    (1..5).each do |value|
      movie = day.movies.build(title: 'Test', year: 2024, rating: value)
      expect(movie).to be_valid
    end
  end

  it 'does not allow rating outside 1..5' do
    day = create(:day)

    movie = day.movies.build(
      attributes_for(:movie, rating: 6)
    )

    expect(movie).not_to be_valid
    expect(movie.errors[:rating]).to be_present
  end
end
