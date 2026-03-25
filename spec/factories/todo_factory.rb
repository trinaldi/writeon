FactoryBot.define do
  factory :todo do
    done { Faker::Boolean.boolean }
    task { Faker::Lorem.sentence }
  end
end
