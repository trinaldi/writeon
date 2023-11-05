require 'rails_helper'

describe 'Comment[s] Mutation', type: :request do
  include_context 'GraphQL Client'

  context 'when a new comment is present' do
    let(:new_post) { create(:post) }
    let(:new_comment) { build(:comment) }
    let(:new_comment_response) { graph_response[:data] }
    let(:query) do
      <<-GRAPHQL
      mutation AddComent($message: String!, $postId: String!) {
        addComment(input: { message: $message, postId: $postId  }) {
          errors
          post {
            body
            id
            title
            comment {
              id
              message
            }
            todo {
              id
            }
          }
        }
      }
      GRAPHQL
    end

    before do
      post_graph(query, { message: new_comment.message, postId: new_post.id.to_s })
      new_post.reload
    end

    it 'will save it' do
      expect(new_post.comment.count).to eq(2)
    end

    it 'will have the correct data' do
      expect(new_comment_response['addComment']['post']['comment'][1]).to include(
        'message' => new_comment.message
      )
    end
  end
end
