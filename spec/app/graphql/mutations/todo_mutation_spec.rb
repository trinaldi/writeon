require 'rails_helper'

describe 'Todo[s] Mutation', type: :request do
  include_context 'GraphQL Client'

  context 'when a new to do is present' do
    let(:my_post) { create(:post) }
    let(:new_todo) { build(:todo) }
    let(:new_todo_response) { graph_response[:data] }
    let(:query) do
      <<-GRAPHQL
      mutation AddTodo($postId: String!, $done: Boolean!, $task: String!) {
        addTodo(input: { postId: $postId, done: $done, task: $task }) {
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
                   postId: my_post.id.to_s,
                   done: new_todo.done,
                   task: new_todo.task
                 })
      my_post.reload
    end

    it 'saves it' do
      expect(my_post.todo.count).to eq(2)
    end

    it 'has the correct data' do
      expect(new_todo_response['addTodo']['post']['todo'][1]).to include(
        'done' => new_todo.done,
        'task' => new_todo.task
      )
    end
  end
end
