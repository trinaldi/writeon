require 'rails_helper'

describe 'Mood Mutation', type: :request do
  include_context 'GraphQL Client'

  context 'when a new mood is present' do
    let(:my_post) { create(:post, mood: nil) }
    let(:new_mood) { build(:mood) }
    let(:new_mood_response) { graph_response[:data] }
    let(:query) do
      <<-GRAPHQL
      mutation AddMood( $mood: String!, $postId: String! ) {
        addMood(input: { mood: $mood, postId: $postId}) {
          clientMutationId
          errors
          post {
            body
            comment {
              id
              message
              name
            }
            id
            mood {
              id
              mood
            }
            title
            todo {
              done
              id
              task
            }
          }
        }
      }
      GRAPHQL
    end

    before do
      post_graph(query, { mood: new_mood.mood, postId: my_post.id.to_s })
      my_post.reload
    end

    it 'will save it' do
      expect(my_post.mood).to be_truthy
    end

    it 'will have the correct data' do
      expect(new_mood_response['addMood']['post']['mood']).to include(
        'mood' => new_mood.mood.to_s
      )
    end
  end
end
