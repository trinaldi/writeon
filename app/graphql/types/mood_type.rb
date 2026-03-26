module Types
  class MoodType < BaseObject
    description 'Mood recorded for a day'

    field :id, GraphQL::Types::ID, null: false,
                                   description: 'Unique identifier for the mood entry'

    field :mood, MoodEnum, null: false,
                           description: 'Mood level for the day'

    def mood
      object.mood.to_s
    end
  end
end
