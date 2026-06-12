require 'rails_helper'

describe 'Add affirmation mutation', type: :request do
  include_context 'with GraphQL Client'

  let(:query) do
    <<-GRAPHQL
    mutation AddAffirmation($body: String, $author: String) {
      addAffirmation(input: { body: $body , author: $author }) {
        errors
        affirmation {
          id
          body
          author
        }
      }
    }
    GRAPHQL
  end

  context 'when new affirmation is created' do
    let(:user) { create(:user) }
    let(:affirmation) { build(:affirmation, user: user) }

    before do
      post_graph(query, {
                   body: affirmation.body,
                   author: affirmation.author
                 },
                 context: { current_user: user })
    end

    it 'correctly creates it' do
      expect(Affirmation.count).to eq(1)
      expect(graph_response['data']['addAffirmation']['affirmation']['author']).to eq(affirmation.author)
      expect(graph_response['data']['addAffirmation']['affirmation']['body']).to eq(affirmation.body)
      expect(graph_response['data']['addAffirmation']['errors']).to be_empty
    end
  end

  context 'when body is blank' do
    let(:user) { create(:user) }
    let(:affirmation) { build(:affirmation, user: user) }

    before do
      post_graph(query, {
                   body: '',
                   author: affirmation.author
                 },
                 context: { current_user: user })
    end

    it 'returns an error' do
      expect(graph_response['data']['addAffirmation']['errors']).to include("Body can't be blank")
      expect(Affirmation.count).to eq(0)
    end
  end

  context 'when body is nil' do
    let(:user) { create(:user) }
    let(:affirmation) { build(:affirmation, user: user) }

    before do
      post_graph(query, {
                   body: nil,
                   author: affirmation.author
                 },
                 context: { current_user: user })
    end

    it 'returns a model validation error' do
      expect(graph_response['data']['addAffirmation']['errors']).not_to be_empty
      expect(Affirmation.count).to eq(0)
    end
  end

  context 'when author is not provided' do
    let(:user) { create(:user) }
    let(:affirmation) { build(:affirmation, user: user) }

    before do
      post_graph(query, {
                   body: affirmation.body,
                   author: nil
                 },
                 context: { current_user: user })
    end

    it 'creates affirmation without author' do
      expect(Affirmation.count).to eq(1)
      expect(graph_response['data']['addAffirmation']['affirmation']['author']).to be_nil
    end
  end
end
