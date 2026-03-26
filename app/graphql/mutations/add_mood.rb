module Mutations
  class AddMood < Mutations::BaseMutation
    argument :day_id, String, required: true, description: 'Day ID'
    argument :mood, String, required: true, description: 'Current Mood'

    field :errors, [String], null: false
    field :day, Types::DayType, null: true

    def resolve(mood:, day_id:)
      day = Day.find(day_id)
      day.build_mood(mood: mood)
      day.save
      { day: day.persisted? ? day : nil, errors: day.errors.full_messages }
    rescue Mongoid::Errors::DocumentNotFound
      { day: nil, errors: ['Day not found'] }
    end
  end
end
