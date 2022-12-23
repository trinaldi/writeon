FactoryBot.define do
  factory :todo do
    done { Faker::Boolean.boolean }
    task { Faker::Book.title }
  end
end
