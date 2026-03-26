FactoryBot.define do
  factory :journal do
    content { Faker::Lorem.paragraph }
  end
end
