require 'rails_helper'

describe 'Rate limiting', type: :request do
  it 'allows requests within the limit' do
    60.times { post '/graphql', params: { query: '{ days { id } }' } }
    expect(response.status).to eq(200)
  end

  it 'throttles after 60 requests' do
    61.times { post '/graphql', params: { query: '{ days { id } }' } }
    expect(response.status).to eq(429)
  end
end
