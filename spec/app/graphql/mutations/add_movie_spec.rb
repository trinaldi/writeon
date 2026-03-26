# spec/app/graphql/mutations/add_movie_spec.rb
require 'rails_helper'

describe 'Add Movie mutation', type: :request do
  include_context 'with GraphQL Client'

  let!(:day) { create(:day) }
  let(:new_movie) { build(:movie) }
  let(:query) do
    <<-GRAPHQL
    mutation AddMovie($dayId: ID!, $title: String!, $year: Int!, $rating: Int!) {
      addMovie(input: { dayId: $dayId, title: $title, year: $year, rating: $rating }) {
        errors
        movie {
          id
          title
          year
          rating
        }
      }
    }
    GRAPHQL
  end

  context 'when movie is added successfully' do
    before do
      post_graph(query, {
                   dayId: day.id.to_s,
                   title: new_movie.title,
                   year: new_movie.year,
                   rating: new_movie.rating
                 })
    end

    it 'has the correct data' do
      expect(graph_response['data']['addMovie']['movie']).to include(
        'title' => new_movie.title,
        'year' => new_movie.year,
        'rating' => new_movie.rating
      )
    end
  end

  context 'when day is not found' do
    before do
      post_graph(query, { dayId: 'invalid_id', title: new_movie.title, year: new_movie.year, rating: new_movie.rating })
    end

    it 'returns an error' do
      expect(graph_response['data']['addMovie']['errors']).to include('Day not found')
    end
  end
end
