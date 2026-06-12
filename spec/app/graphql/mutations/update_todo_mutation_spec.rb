require 'rails_helper'

describe 'Update to do mutation', type: :request do
  include_context 'with GraphQL Client'

  let!(:user) { create(:user) }
  let!(:day) { create(:day, todos: [{ task: 'update me', done: false }]) }
  let(:query) do
    <<-GRAPHQL
    mutation UpdateTodo($done: Boolean!, $dayId: String!, $todoId: String!){
      updateTodo(input: { done: $done, dayId: $dayId, todoId: $todoId }) {
        errors
        day {
          id
          date
          todos {
            id
            done
            task
          }
        }
      }
    }
    GRAPHQL
  end

  context 'when user is not authenticated' do
    it 'returns a not authenticated error' do
      post_graph(query, { dayId: day.id.to_s, todoId: day.todos.first.id.to_s, done: true })
      expect(graph_response['errors'].first['message']).to eq('Not authenticated')
    end
  end

  context 'when to do is updated' do
    before do
      post_graph(query, { dayId: day.id.to_s, todoId: day.todos.first.id.to_s, done: true },
                 context: { current_user: user })
    end

    it 'correctly updates it' do
      expect(day.reload.todos.first.done).to be(true)
    end

    context 'when day is not found' do
      before do
        post_graph(query, { dayId: 'invalid_id', todoId: 'invalid_id', done: true }, context: { current_user: user })
      end

      it 'returns an error' do
        expect(graph_response['data']['updateTodo']['errors']).to include('Record not found')
      end
    end

    context 'when todo is not found' do
      before do
        post_graph(query, { dayId: day.id.to_s, todoId: 'invalid_id', done: true }, context: { current_user: user })
      end

      it 'returns an error' do
        expect(graph_response['data']['updateTodo']['errors']).to include('Record not found')
      end
    end
  end
end
