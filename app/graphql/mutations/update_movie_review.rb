module Mutations
  class UpdateMovieReview < Mutations::BaseMutation
    argument :movie_id, String, required: true
    argument :review, String, required: false

    field :errors, [String], null: false
    field :movie, Types::MovieType, null: true

    def resolve(movie_id:, review:)
      authenticate_user!

      day = current_user.days.where('movies._id' => movie_id).first
      raise GraphQL::ExecutionError, 'Record not found' unless day

      movie = day.movies.where(_id: movie_id).first
      raise GraphQL::ExecutionError, 'Record not found' unless movie

      success = movie.update(review: review)

      {
        movie: success ? movie : nil,
        errors: success ? [] : movie.errors.full_messages
      }
    end
  end
end
