FactoryBot.define do
  factory :affirmation do
    user
    body { Faker::Lorem.paragraph }
    author { Faker::Name.name }
  end
end
