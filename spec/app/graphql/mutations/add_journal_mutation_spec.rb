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
                                                                           'content' => my_journal.content,
                                                                         })
    end
  end
end
