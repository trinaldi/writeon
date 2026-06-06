# rubocop: disable GraphQL/MaxComplexitySchema
class BlogSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  use GraphQL::Dataloader

  max_depth Rails.env.development? ? nil : 10
  validate_max_errors(100)

  def self.execute(query = nil, variables: nil, context: {}, operation_name: nil, **kwargs)
    ensure_authenticated!(context)
    super
  end

  def self.ensure_authenticated!(context)
    return if context[:current_user].present?

    raise GraphQL::ExecutionError, 'Not authenticated'
  end
end
# rubocop: enable GraphQL/MaxComplexitySchema
