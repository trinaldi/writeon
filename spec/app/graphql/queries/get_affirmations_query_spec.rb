require 'rails_helper'

describe 'Get Affirmations Query', type: :request do
  include_context 'with GraphQL Client'

  let!(:user) { create(:user) }
  let!(:visible_affirmation) { create(:affirmation, show: true, user: user) }
  let!(:hidden_affirmation)  { create(:affirmation, show: false, user: user) }
  let(:query) do
    <<-GRAPHQL
    query Affirmations($show: Boolean) {
      affirmations(show: $show) {
        id
        body
        show
      }
    }
    GRAPHQL
  end

  context 'when filtering visible affirmations' do
    before do
      post_graph(query, { show: true }, context: { current_user: user })
    end

    it 'returns only visible affirmations' do
      result = graph_response['data']['affirmations']

      expect(result.length).to eq(1)
      expect(result.first['id']).to eq(visible_affirmation.id.to_s)
      expect(result.first['show']).to be(true)
    end
  end

  context 'when filtering hidden affirmations' do
    before do
      post_graph(query, { show: false }, context: { current_user: user })
    end

    it 'returns only hidden affirmations' do
      result = graph_response['data']['affirmations']
      expect(result.length).to eq(1)
      expect(result.first['id']).to eq(hidden_affirmation.id.to_s)
      expect(result.first['show']).to be(false)
    end
  end

  context 'when no filter is applied' do
    before do
      post_graph(query, {}, context: { current_user: user })
    end

    it 'returns all affirmations' do
      result = graph_response['data']['affirmations']

      expect(result.length).to eq(2)
    end
  end
end
