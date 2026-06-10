RSpec.shared_context 'with GraphQL Client', shared_context: :metadata do
  def post_graph(query, variables = {}, context: {})
    headers = {}

    if context[:current_user]
      token = Auth::JwtEncoder.call(context[:current_user])
      headers['Authorization'] = "Bearer #{token}"
    end

    post '/graphql',
         params: { query: query, variables: variables }, headers: headers, as: :json
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
    unless response.content_type&.include?('application/json')
      error_text = response.body.gsub(/<[^>]+>/, ' ').gsub(/\s+/, ' ').strip.slice(0, 800)
      raise "HTML response (#{response.status}): #{error_text}"
    end
    JSON.parse(response.body, symbolize_names: true).with_indifferent_access
  end
end
