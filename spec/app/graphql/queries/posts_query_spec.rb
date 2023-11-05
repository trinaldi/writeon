require 'rails_helper'

describe 'Posts Query', type: :request do
  include_context 'GraphQL Client'

  context 'when calling posts query' do
    let!(:posts) { create(:post) }
    let(:query) do
      <<-GRAPHQL
    {
      posts {
        id
        title
        body
        comment {
          id
          name
          message
        }
        todo {
          id
          done
          task
        }
      }
    }
      GRAPHQL
    end
    let(:posts_query_response) { graph_response[:data] }
    let(:search_posts) do
      {
        'posts' => [{
          'id' => posts.id.to_s,
          'title' => posts.title,
          'body' => posts.body,
          'comment' => posts.comment.map do |c|
            {
              'id' => c.id.to_s,
              'name' => c.name,
              'message' => c.message
            }
          end,
          'todo' => posts.todo.map do |t|
            {
              'id' => t.id.to_s,
              'done' => t.done,
              'task' => t.task
            }
          end
        }]
      }
    end

    before do
      post_graph(query)
    end

    it 'returns the post' do
      expect(posts_query_response).to eq(search_posts)
    end
  end
end
