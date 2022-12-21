FactoryBot.define do
  factory :comment do
    name { Faker::Name.first_name }
    message { Faker::Quote.famous_last_words }
  end
end
