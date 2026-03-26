require 'rails_helper'

describe 'Mood Mutation', type: :request do
  include_context 'with GraphQL Client'

  context 'when a new mood is present' do
    let!(:day) { create(:day) }
    let(:new_mood) { build(:mood) }
    let(:query) do
      <<-GRAPHQL
      mutation AddMood( $mood: String!, $dayId: String! ) {
        addMood(input: { mood: $mood, dayId: $dayId}) {
          clientMutationId
          errors
          day {
            id
            date
            mood {
              id
              mood
            }
          }
        }
      }
      GRAPHQL
    end

    before do
      post_graph(query, { mood: new_mood.mood, dayId: day.id.to_s })
    end

    it 'has the correct data' do
      expect(graph_response['data']['addMood']['day']['mood']).to eq(
        'id' => day.reload.mood.id.to_s,
        'mood' => new_mood.mood.to_s
      )
    end

    context 'when day is not found' do
      before do
        post_graph(query, { mood: new_mood.mood, dayId: 'invalid_id' })
      end

      it 'returns an error' do
        expect(graph_response['data']['addMood']['errors']).to include('Day not found')
      end
    end
  end
end
