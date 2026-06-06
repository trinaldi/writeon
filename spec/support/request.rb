RSpec.shared_context 'with GraphQL Client', shared_context: :metadata do
  def post_graph(query, variables = {}, context: {})
    headers = {}

    if context[:current_user]
      token = Auth::JwtEncoder.call(context[:current_user])
      headers['Authorization'] = "Bearer #{token}"
    end

    post '/graphql',
         params: { query: query, variables: variables }, headers: headers
  end

  def build_headers(context)
    headers = {}

    if context[:current_user]
      token = Auth::JwtEncoder.call(context[:current_user])
      headers['Authorization'] = "Bearer #{token}"
    end

    headers
  end

  def graph_response
    JSON.parse(response.body, symbolize_names: true).with_indifferent_access
  end
end
