require 'rails_helper'

describe 'Update comment mutation', type: :request do
  include_context 'GraphQL Client'

  context 'when a comment is updated' do
    let(:comment_to_change) { build(:comment, message: 'me me me me') }
    let(:post_with_comment) { create(:post, comment: [comment_to_change]) }
    let(:changed_post_response) { graph_response[:data] }
    let(:query) do
      <<-GRAPHQL
      mutation UpdateComment($postId: String!, $commentId: String!, $message: String!) {
        updateComment(input: {postId: $postId, commentId: $commentId, message: $message}) {
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
              done
              task
            }
          }
        }
      }
      GRAPHQL
    end

    before do
      post_graph(query, {
                   commentId: comment_to_change.id.to_s,
                   message: comment_to_change.message,
                   postId: post_with_comment.id.to_s
                 })
      post_with_comment.reload
    end

    it 'will replace the post comment with new message' do
      expect(post_with_comment.comment.first.message).to eq(comment_to_change.message)
    end
  end
end
