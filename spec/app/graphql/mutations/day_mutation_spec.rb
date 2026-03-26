require 'rails_helper'

describe 'Add Day mutation', type: :request do
  include_context 'GraphQL Client'

  context 'when a new day is created' do
    let(:my_day) { build(:day, date: Date.new(2026, 3, 25)) }
    let(:query) do
      <<-GRAPHQL
      mutation AddDay($date: ISO8601Date!) {
        addDay(input: { date: $date }) {
          errors
          day {
            id
            date
          }
        }
      }
      GRAPHQL
    end

    before do
      post_graph(query, { date: my_day.date })
    end

    it 'creates a day' do
      expect(Day.count).to eq(1)
    end

    it 'has the correct data' do
      expect(graph_response['data']['addDay']['day']).to include({
                                                                   'date' => my_day.date.to_s
                                                                 })
    end

    it 'does not allow duplicate dates' do
      dummy_day = build(:day, date: my_day.date)
      post_graph(query, { date: dummy_day.date })

      expect(graph_response['data']['addDay']['errors']).to include('Date has already been taken')
      expect(Day.count).to eq(1)
    end
  end
end
