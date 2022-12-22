FactoryBot.define do
  factory :post do
    title { Faker::Book.title }
    body { Faker::Quote.famous_last_words }
    comment { [build(:comment)] }
  end
end
