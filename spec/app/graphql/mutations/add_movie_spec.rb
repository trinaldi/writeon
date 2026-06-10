require 'rails_helper'

describe 'Add Movie mutation', type: :request do
  include_context 'with GraphQL Client'

  let!(:user) { create(:user) }
  let!(:day) { create(:day) }
  let(:new_movie) { build(:movie) }
  let(:query) do
    <<-GRAPHQL
    mutation AddMovie($dayId: ID!, $title: String!, $year: Int!, $rating: Int!) {
      addMovie(input: { dayId: $dayId, title: $title, year: $year, rating: $rating }) {
        errors
        day {
          movies {
            title
            year
            rating
          }
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
                 }, context: { current_user: user })
    end

    it 'has the correct data' do
      expect(graph_response['data']['addMovie']['day']['movies']).to include(
        'title' => new_movie.title,
        'year' => new_movie.year,
        'rating' => new_movie.rating
      )
    end
  end

  context 'when day is not found' do
    before do
      post_graph(query,
                 { dayId: 'invalid_id',
                   title: new_movie.title,
                   year: new_movie.year,
                   rating: new_movie.rating },
                 context: { current_user: user })
    end

    it 'returns an error' do
      expect(graph_response['data']['addMovie']['errors']).to include('Day not found')
    end
  end

  context 'when user is not authenticated' do
    before do
      # post_graph sem context: { current_user: } = sem JWT no header
      post_graph(query, {
                   dayId: day.id.to_s,
                   title: new_movie.title,
                   year: new_movie.year,
                   rating: new_movie.rating
                 })
    end

    it 'returns a not authenticated error' do
      expect(graph_response['errors'].first['message']).to eq('Not authenticated')
    end
  end
end
