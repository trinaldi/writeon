require 'rails_helper'

describe 'Update to do mutation', type: :request do
  include_context 'with GraphQL Client'

  context 'when to do is updated' do
    let!(:day) { create(:day, todos: [{ task: 'update me', done: false }]) }
    let(:query) do
      <<-GRAPHQL
      mutation UpdateTodo($done: Boolean!, $dayId: String!, $todoId: String!){
        updateTodo(input: { done: $done , dayId: $dayId, todoId: $todoId  }) {
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

    before do
      post_graph(query, {
                   dayId: day.id.to_s,
                   todoId: day.todos.first.id.to_s,
                   done: true
                 })
    end

    it 'correctly updates it' do
      expect(day.reload.todos.first.done).to be(true)
    end

    context 'when day is not found' do
      before do
        post_graph(query, { dayId: 'invalid_id', todoId: 'invalid_id', done: true })
      end

      it 'returns an error' do
        expect(graph_response['data']['updateTodo']['errors']).to include('Record not found')
      end
    end

    context 'when todo is not found' do
      before do
        post_graph(query, { dayId: day.id.to_s, todoId: 'invalid_id', done: true })
      end

      it 'returns an error' do
        expect(graph_response['data']['updateTodo']['errors']).to include('Record not found')
      end
    end
  end
end
