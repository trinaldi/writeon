require 'rails_helper'

describe 'Soft delete affirmation mutation', type: :request do
  include_context 'with GraphQL Client'

  let!(:user) { create(:user) }
  let!(:affirmation) { create(:affirmation, user: user) }
  let(:query) do
    <<-GRAPHQL
    mutation ToggleAffirmation($affirmationId: String!){
      toggleAffirmation(input: { affirmationId: $affirmationId }) {
        errors
        affirmation {
          id
          body
          show
        }
      }
    }
    GRAPHQL
  end

  context 'when user is not authenticated' do
    it 'returns a not authenticated error' do
      post_graph(query, { affirmationId: affirmation.id.to_s })
      expect(graph_response['errors'].first['message']).to eq('Not authenticated')
    end
  end

  context 'when affirmation is shown' do
    let!(:shown_affirmation) { create(:affirmation, show: true, user: user) }

    before do
      post_graph(query, { affirmationId: shown_affirmation.id.to_s },
                 context: { current_user: user })
    end

    it 'correctly hides it' do
      expect(shown_affirmation.reload.show).to be(false)
    end

    context 'when affirmation is not shown' do
      let!(:hidden_affirmation) { create(:affirmation, show: false, user: user) }

      before do
        post_graph(query, { affirmationId: hidden_affirmation.id.to_s },
                   context: { current_user: user })
      end

      it 'correctly hides it' do
        expect(hidden_affirmation.reload.show).to be(true)
      end
    end

    context 'when affirmation is not found' do
      before do
        post_graph(query, { affirmationId: 'bogus_id' }, context: { current_user: user })
      end

      it 'returns an error' do
        expect(graph_response['data']['toggleAffirmation']['errors']).to include('Record not found')
      end
    end
  end
end
