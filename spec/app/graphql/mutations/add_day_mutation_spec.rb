require 'rails_helper'

describe 'Add Day mutation', type: :request do
  include_context 'with GraphQL Client'

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

  context 'when a new day is created' do
    let(:user) { create(:user) }
    let(:my_day) { build(:day, date: Date.new(2026, 3, 25)) }

    before do
      post_graph(
        query,
        { date: my_day.date },
        context: { current_user: user }
      )
    end

    it 'creates with the correct data' do
      expect(Day.count).to eq(1)
      expect(graph_response['data']['addDay']['day']).to include({
                                                                   'date' => my_day.date.to_s
                                                                 })
    end

    it 'does not allow duplicate dates' do
      dummy_day = build(:day, date: my_day.date)
      post_graph(query, { date: dummy_day.date }, context: { current_user: user })

      expect(graph_response['data']['addDay']['errors']).to include('Date has already been taken')
      expect(Day.count).to eq(1)
    end
  end

  context 'when two users try to create a day on the same date' do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }
    let(:date) { Date.new(2026, 3, 25) }

    it 'allows both since they are different users' do
      post_graph(query, { date: date }, context: { current_user: user_a })
      post_graph(query, { date: date }, context: { current_user: user_b })

      expect(Day.count).to eq(2)
    end

    it 'returns the day scoped to the correct user' do
      post_graph(query, { date: date }, context: { current_user: user_a })

      expect(user_a.days.count).to eq(1)
      expect(user_b.days.count).to eq(0)
    end
  end
end
