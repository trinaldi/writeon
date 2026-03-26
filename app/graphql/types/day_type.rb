module Types
  class DayType < BaseObject
    description 'A single day entry'

    field :id, GraphQL::Types::ID, null: false,
                                   description: 'Unique identifier for the day'

    field :date, GraphQL::Types::ISO8601Date, null: false,
                                              description: 'Calendar date of this entry'

    field :journal, JournalType, null: true,
                                 description: 'Journal entry written for this day'

    field :mood, MoodType, null: true,
                           description: 'Overall mood recorded for the day'

    field :movies, [MovieType], null: false,
                                description: 'Movies watched on this day'

    field :todos, [TodoType], null: false,
                              description: 'Tasks tracked for this day'
  end
end
