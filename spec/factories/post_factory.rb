FactoryBot.define do
  factory :post do
    title { Faker::Book.title }
    body { Faker::Quote.famous_last_words }
    comment { [build(:comment)] }
    todo { [build(:todo)] }
    mood { build(:mood) }
  end
end
