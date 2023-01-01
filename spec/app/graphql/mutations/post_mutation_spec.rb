require 'rails_helper'

describe 'Create Post mutation', type: :request do
  include_context 'GraphQL Client'

  context 'when a new post is present' do
    let(:my_post) { build(:post) }
    let(:new_post_response) { graph_response[:data] }
    let(:query) do
      <<-GRAPHQL
      mutation CreatePost($title: String!, $body: String!) {
        createPost(input: { title: $title, body: $body }) {
          errors
          post {
            body
            id
            title
          }
        }
      }
      GRAPHQL
    end

    before do
      post_graph(query, {
                   title: my_post.title,
                   body: my_post.body
                 })
    end

    it 'will create a post' do
      expect(Post.count).to eq(1)
    end

    it 'will have the correct data' do
      expect(new_post_response['createPost']['post']).to include({
                                                                   'title' => my_post.title,
                                                                   'body' => my_post.body
                                                                 })
    end
  end
end
