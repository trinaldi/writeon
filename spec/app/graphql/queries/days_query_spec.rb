require 'rails_helper'

describe 'Days Query', type: :request do
  include_context 'GraphQL Client'

  context 'when calling days query' do
    let!(:day) { create(:day) }
    let!(:todos) { create_list(:todo, 2, day: day) }
    let!(:journal) { day.create_journal(attributes_for(:journal)) }
    let!(:note) { day.journal.notes.create!(attributes_for(:note)) }
    let!(:movies) { day.movies.create!(attributes_for(:movie)) }

    let(:query) do
      <<-GRAPHQL
    {
      days {
        id
        date
        todos {
          id
          done
          task
        }
        journal {
          content
          notes {
            id
            content
            happenedAt
          }
        }
        movies {
          title
          year
          rating
        }
      }
    }
      GRAPHQL
    end

    let(:days_query_response) { graph_response[:data] }

    let(:expected_response) do
      {
        'days' => [{
          'id' => day.id.to_s,
          'date' => day.date.to_s,
          'todos' => todos.map do |t|
            {
              'id' => t.id.to_s,
              'done' => t.done,
              'task' => t.task
            }
          end,
          'journal' => {
            'content' => journal.content,
            'notes' => journal.notes.map do |n|
              {
                'id' => n.id.to_s,
                'content' => n.content,
                'happenedAt' => n.happened_at.iso8601
              }
            end
          },
          'movies' => [{
            'title' => movies.title,
            'year' => movies.year,
            'rating' => movies.rating
          }]
        }]
      }
    end

    before do
      post_graph(query)
    end

    it 'returns the days with associations' do
      expect(days_query_response).to eq(expected_response)
    end
  end
end
