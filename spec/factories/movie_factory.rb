FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    year { Faker::Number.between(from: 1990, to: Time.zone.today.year) }
    rating { Faker::Number.between(from: 1, to: 5) }
    plot { Faker::Lorem.sentence }
    review { Faker::Lorem.paragraph }
    watched_at { Faker::Time.backward(days: 1) }
  end
end
