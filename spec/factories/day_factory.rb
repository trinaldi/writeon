FactoryBot.define do
  factory :day do
    sequence(:date) { |n| Time.zone.today - n.days }

    trait :with_todos do
      after(:create) do |day|
        create_list(:todo, 2, day: day)
      end
    end

    trait :with_journal do
      after(:create) do |day|
        journal = day.create_journal(FactoryBot.attributes_for(:journal))
        journal.notes.create!(FactoryBot.attributes_for(:note))
      end
    end

    trait :with_movies do
      after(:create) do |day|
        day.movies.create!(FactoryBot.attributes_for(:movie))
      end
    end

    trait :full do
      with_todos
      with_journal
      with_movies
    end
  end
end
