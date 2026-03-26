require 'rails_helper'

describe 'Add Todo mutation', type: :request do
  include_context 'GraphQL Client'

  let(:day) { create(:day) }
  let(:todo) { attributes_for(:todo) }
  let(:query) do
    <<-GRAPHQL
    mutation AddTodo($dayId: ID!, $task: String!, $done: Boolean) {
      addTodo(input: { dayId: $dayId, task: $task, done: $done }) {
        errors
        todo {
          id
          task
          done
        }
      }
    }
    GRAPHQL
  end

  let(:data) { graph_response['data']['addTodo'] }

  it 'creates a todo for a day' do
    post_graph(query, { dayId: day.id, task: todo[:task], done: todo[:done] })
    day.reload

    expect(data['errors']).to be_empty
    expect(data['todo']).to include('task' => todo[:task], 'done' => todo[:done])
    expect(day.todos.count).to eq(1)
  end

  it 'fails if day_id does not exist' do
    post_graph(query, { dayId: 'nonexistent', task: todo[:task] })

    expect(data['errors']).to include('Day not found')
    expect(data['todo']).to be_nil
  end
end
