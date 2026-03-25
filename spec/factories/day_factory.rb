FactoryBot.define do
  factory :day do
    sequence(:date) { |n| Time.zone.today - n.days }
  end
end
