require 'rails_helper'

describe 'Get Affirmations Query', type: :request do
  include_context 'with GraphQL Client'

  let!(:user) { create(:user) }
  let!(:affirmation) { create(:affirmation, show: true, user: user) }
  let!(:query) do
    <<-GRAPHQL
    {
      affirmations {
        id
        body
        author
        show
      }
    }
    GRAPHQL
  end

  context 'when user is not authenticated' do
    before { post_graph(query) }

    it 'returns a not authenticated error' do
      expect(graph_response['errors'].first['message']).to eq('Not authenticated')
    end
  end

  context 'when calling days query' do
    let(:expected_response) do
      {
        'affirmations' => [{
          'id' => affirmation.id.to_s,
          'body' => affirmation.body,
          'author' => affirmation.author,
          'show' => true
        }]
      }
    end

    before { post_graph(query, context: { current_user: user }) }

    it 'returns the shown affirmations with associations' do
      expect(graph_response[:data]).to eq(expected_response)
    end
  end
end
