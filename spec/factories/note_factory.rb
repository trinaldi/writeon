FactoryBot.define do
  factory :note do
    content { Faker::Lorem.sentence }
    happened_at { Faker::Time.backward(days: 1) }
  end
end
