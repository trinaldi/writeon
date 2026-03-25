module Mutations
  class AddMood < Mutations::BaseMutation
    argument :day_id, String, required: true, description: 'Day ID'
    argument :mood, String, required: true, description: 'Current Mood'

    field :errors, [String], null: false
    field :day, Types::DayType, null: false

    def resolve(mood:, day_id:)
      @day = Day.find(day_id)
      @mood = Mood.new(mood: mood)

      if @mood.valid?
        @day.mood = @mood

        { day: @day, errors: [] }
      else
        { day: nil, errors: day.errors.full_messages }
      end
    end
  end
end
