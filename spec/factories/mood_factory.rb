FactoryBot.define do
  factory :mood do
    mood { %i[very_bad bad neutral good very_good].sample }
  end
end
