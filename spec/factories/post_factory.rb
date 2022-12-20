FactoryBot.define do
  factory :post do
    title { Faker::Book.title }
    body { Faker::Quote.famous_last_words }
  end
end
