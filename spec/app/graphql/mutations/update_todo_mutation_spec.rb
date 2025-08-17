require 'rails_helper'

describe 'Update to do mutation', type: :request do
  include_context 'GraphQL Client'

  context 'when to do is updated' do
    let(:my_todo) { build(:todo, done: false) }
    let(:my_post) { create(:post, todo: [my_todo]) }
    let(:query) do
      <<-GRAPHQL
      mutation UpdateTodo($done: Boolean!, $postId: String!, $todoId: String!){
        updateTodo(input: { done: $done , postId: $postId, todoId: $todoId  }) {
                errors
                post {
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
            }
      GRAPHQL
    end

    before do
      post_graph(query, {
                   postId: my_post.id.to_s,
                   todoId: my_post.todo.first.id.to_s,
                   done: true
                 })
      my_post.reload
    end

    it 'correctlies update it' do
      expect(my_post.todo.first.done).to be(true)
    end
  end
end
