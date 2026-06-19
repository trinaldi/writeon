require 'rails_helper'

describe 'Update Movie review mutation', type: :request do
  include_context 'with GraphQL Client'

  let!(:user) { create(:user) }
  let!(:day) { create(:day, :with_movies, user: user) }
  let(:to_be_updated) { build(:movie, review: "I'm updated") }
  let(:new_movie) { build(:movie) }
  let(:query) do
    <<-GRAPHQL
      mutation UpdateMovieReview($movieId: String!, $review: String) {
        updateMovieReview(
          input: { movieId: $movieId review: $review }) {
          errors
          movie {
            id
            title
            review
          }
        }
      }
    GRAPHQL
  end

  context 'when movie review is updated successfully' do
    before do
      post_graph(query, {
                   movieId: day.movies.first.id.to_s,
                   review: to_be_updated.review
                 }, context: { current_user: user })
    end

    it 'displays the correct data' do
      expect(graph_response['data']['updateMovieReview']['movie']).to include(
        'title' => day.movies.first.title,
        'review' => to_be_updated.review
      )
    end
  end

  context 'when movie is not found' do
    before do
      post_graph(query,
                 { movieId: 'invalid_id',
                   review: to_be_updated.review },
                 context: { current_user: user })
    end

    it 'returns an error' do
      expect(graph_response['errors'].first['message']).to eq('Record not found')
    end
  end

  context 'when user is not authenticated' do
    before do
      post_graph(query, {
                   movieId: new_movie.id.to_s,
                   review: new_movie.review
                 })
    end

    it 'returns a not authenticated error' do
      expect(graph_response['errors'].first['message']).to eq('Not authenticated')
    end
  end
end
