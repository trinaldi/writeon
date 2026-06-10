require 'rails_helper'

describe 'Mutations::LoginUser', type: :request do
  include_context 'with GraphQL Client'

  let(:user) { create(:user) }

  let(:query) do
    <<~GQL
      mutation LoginUser($email: String!, $password: String!) {
        loginUser(input: { email: $email, password: $password }) {
          token
          userId
        }
      }
    GQL
  end

  before do
    post_graph(
      query,
      { email: user.email, password: user.password }
    )
  end

  context 'when credentials are valid' do
    it 'returns JWT and User ID' do
      expect(graph_response['data']['loginUser']['userId']).to eq(user.id.to_s)
      expect(graph_response['data']['loginUser']['token']).to be_present
      expect(response).to have_http_status(:ok)
    end
  end

  context 'when credentials are invalid' do
    before do
      post_graph(
        query,
        {
          email: user.email,
          password: 'wrong-password'
        }
      )
    end

    it 'returns an authentication error' do
      expect(graph_response['data']['loginUser']).to be_nil
      expect(graph_response['errors']).to be_present
      expect(graph_response['errors'].first['message'])
        .to eq('Invalid email or password')
    end
  end

  context 'when email does not exist' do
    before do
      post_graph(
        query,
        {
          email: 'missing@example.com',
          password: user.password
        }
      )
    end

    it 'returns an authentication error' do
      expect(graph_response['data']['loginUser']).to be_nil
      expect(graph_response['errors'].first['message'])
        .to eq('Invalid email or password')
    end
  end
end
