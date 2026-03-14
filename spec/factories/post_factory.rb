FactoryBot.define do
  factory :post do
    title { Faker::Book.title }
    body { Faker::Quote.famous_last_words }
    comments { [build(:comment)] }
    todos { [build(:todo)] }
    mood { build(:mood) }
  end
end
