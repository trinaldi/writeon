module Mutations
  class AddMovie < Mutations::BaseMutation
    argument :day_id, ID, required: true, description: 'Day ID'
    argument :plot, String, required: false, description: 'Optional plot'
    argument :rating, Integer, required: true, description: 'Rating from 1 to 5'
    argument :review, String, required: false, description: 'Optional review'
    argument :title, String, required: true, description: 'Movie title'
    argument :watched_at, GraphQL::Types::ISO8601DateTime, required: false, description: 'When watched'
    argument :year, Integer, required: true, description: 'Release year'

    field :errors, [String], null: false
    field :movie, Types::MovieType, null: true

    def resolve(day_id:, title:, year:, rating:, plot: nil, review: nil, watched_at: nil) # rubocop:disable Metrics/ParameterLists
      day = Day.find(day_id)
      movie = day.movies.build(title: title, year: year, rating: rating, plot: plot, review: review,
                               watched_at: watched_at)
      movie.save
      { movie: movie, errors: movie.errors.full_messages }
    rescue Mongoid::Errors::DocumentNotFound
      { movie: nil, errors: ['Day not found'] }
    end
  end
end
