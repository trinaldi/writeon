require 'rails_helper'

describe 'Mood Mutation', type: :request do
  include_context 'GraphQL Client'

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
  end
end
