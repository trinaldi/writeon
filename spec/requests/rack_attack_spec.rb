require 'rails_helper'

describe 'Rate limiting', type: :request do
  include_context 'with GraphQL Client'

  let(:user) { create(:user) }
  let(:token) { Auth::JwtEncoder.call(user) }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }
  let(:valid_query) { { query: '{ __typename }' } }

  it 'allows requests within the limit' do
    60.times { post '/graphql', params: valid_query, headers: headers }
    expect(response.status).to eq(200)
  end

  it 'throttles after 60 requests' do
    61.times { post '/graphql', params: valid_query, headers: headers }
    expect(response.status).to eq(429)
  end
end
