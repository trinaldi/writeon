require 'rails_helper'

describe 'Days Query', type: :request do
  include_context 'GraphQL Client'

  context 'when calling days query' do
    let!(:day) { create(:day, :full) }
    let!(:query) do
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
          id
          title
          year
          rating
          plot
          review
          watchedAt
        }
      }
    }
      GRAPHQL
    end

    let(:expected_response) do
      {
        'days' => [{
          'id' => day.id.to_s,
          'date' => day.date.to_s,
          'todos' => day.todos.map do |t|
            {
              'id' => t.id.to_s,
              'done' => t.done,
              'task' => t.task
            }
          end,
          'journal' => {
            'content' => day.journal.content,
            'notes' => day.journal.notes.map do |n|
              {
                'id' => n.id.to_s,
                'content' => n.content,
                'happenedAt' => n.happened_at.iso8601
              }
            end
          },
          'movies' => day.movies.map do |m|
            {
              'id' => m.id.to_s,
              'title' => m.title,
              'year' => m.year,
              'rating' => m.rating,
              'plot' => m.plot,
              'review' => m.review,
              'watchedAt' => m.watched_at.iso8601
            }
          end
        }]
      }
    end

    before do
      post_graph(query)
    end

    it 'returns the days with associations' do
      expect(graph_response[:data]).to eq(expected_response)
    end
  end
end
