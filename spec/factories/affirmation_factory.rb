FactoryBot.define do
  factory :affirmation do
    body { Faker::Lorem.paragraph }
    author { Faker::Name.name }
  end
end
