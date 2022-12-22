RSpec.shared_context 'GraphQL Client', shared_context: :metadata do
  def post_graph(query, variables = {})
    post '/graphql', params: { query: query, variables: variables }, as: :json
  end

  def graph_response
    body = @response.body
    parsed_response = JSON.parse(body, { symbolize_names: true }).with_indifferent_access
    return parsed_response unless parsed_response[:errors]

    raise parsed_response[:errors].pluck('message').join
  end
end
