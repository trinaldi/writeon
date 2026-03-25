RSpec.shared_context 'GraphQL Client', shared_context: :metadata do
  def post_graph(query, variables = {})
    post '/graphql', params: { query: query, variables: variables }, as: :json
  end

  def graph_response
    body = @response.body
    JSON.parse(body, { symbolize_names: true }).with_indifferent_access
  end
end
