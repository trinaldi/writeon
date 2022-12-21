FactoryBot.define do
  factory :todo do
    done { Faker::Boolean.boolean }
    description { Faker::Book.title }
  end
end
