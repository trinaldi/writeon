module Types
  class MovieType < BaseObject
    description 'A movie watched on a specific day'

    field :id, GraphQL::Types::ID, null: false,
                                   description: 'Unique identifier for the movie entry'

    field :title, String, null: false,
                          description: 'Title of the movie'

    field :year, Integer, null: false,
                          description: 'Release year of the movie'

    field :rating, Integer, null: false,
                            description: 'Rating given to the movie, from 1 to 5'

    field :plot, String, null: true,
                           description: 'Optional original plot from the movie'

    field :review, String, null: true,
                           description: 'Optional personal review of the movie'

    field :watched_at, GraphQL::Types::ISO8601DateTime, null: false,
                                                        description: 'Date and time when the movie was watched'
  end
end
