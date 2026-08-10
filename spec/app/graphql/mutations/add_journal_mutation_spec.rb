require 'rails_helper'

describe 'Add Journal to day mutation', type: :request do
  include_context 'with GraphQL Client'

  let(:query) do
    <<-GRAPHQL
      mutation AddJournal( $content: String!, $dayId: String! ) {
        addJournal(input: { content: $content, dayId: $dayId}) {
          clientMutationId
          errors
          journal {
            id
            content
          }
        }
      }
    GRAPHQL
  end

  context 'when a new journal is created' do
    let(:my_day) { create(:day, date: Date.new(2026, 3, 25)) }
    let(:my_journal) { build(:journal) }

    before do
      post_graph(
        query,
        { content: my_journal.content, dayId: my_day.id.to_s },
        context: { current_user: my_day.user }
      )
    end

    it 'creates with the correct day and content' do
      expect(graph_response['data']['addJournal']['journal']).to include({
                                                                           'content' => my_journal.content
                                                                         })
    end
  end

  context 'when a user does not own the day' do
    let(:user) { create(:user) }
    let(:my_day) { create(:day) }
    let(:my_journal) { build(:journal) }

    before do
      post_graph(
        query,
        { content: my_journal.content, dayId: my_day.id.to_s },
        context: { current_user: user }
      )
    end

    it 'does not create a new journal' do
      expect(graph_response['data']['addJournal']['journal']).to be_nil
      expect(graph_response['data']['addJournal']['errors']).to include('Day not found')
    end
  end

  context 'when journal content is blank' do
    let(:my_day) { create(:day) }
    let(:my_journal) { build(:journal, content: '') }

    before do
      post_graph(
        query,
        { content: my_journal.content, dayId: my_day.id.to_s },
        context: { current_user: my_day.user }
      )
    end

    it 'returns a validation error' do
      expect(graph_response['errors'].first['message']).to include('Validation of Day failed')
    end
  end

  context 'when day does not exist' do
    let(:my_day) { create(:day) }
    let(:journal) { build(:journal) }

    before do
      post_graph(
        query,
        { content: journal.content, dayId: BSON::ObjectId.new.to_s },
        context: { current_user: my_day.user }
      )
    end

    it 'returns a day not found error' do
      payload = graph_response['data']['addJournal']

      expect(payload['journal']).to be_nil
      expect(payload['errors']).to include('Day not found')
    end
  end

  context 'when day already has a journal' do
    let(:my_day) { create(:day) }
    let(:existing_journal) { create(:journal, day: my_day) }

    before do
      post_graph(
        query,
        { content: 'Something awful', dayId: my_day.id.to_s },
        context: { current_user: my_day.user }
      )
    end

    it 'updates the existing embedded journal' do
      expect(graph_response['data']['addJournal']['journal']['content']).to eq('Something awful')
      expect(my_day.reload.journal.content).to eq('Something awful')
    end
  end
end
