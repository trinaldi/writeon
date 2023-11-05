require 'rails_helper'

describe 'Posts Query', type: :request do
  include_context 'GraphQL Client'

  context 'when calling posts query' do
    let!(:old_post) { create(:post) }
    let(:query) do
      <<-GRAPHQL
    {
      monthPriorPosts {
        id
        title
        body
        mood {
          mood
        }
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

    before do
      post_graph(query)
    end

    it 'returns the post' do
      expect(posts_query_response['monthPriorPosts'].first['title']).to eq(old_post.title)
    end
  end
end
