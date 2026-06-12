# rubocop: disable GraphQL/MaxComplexitySchema
class BlogSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  use GraphQL::Dataloader

  max_depth Rails.env.development? ? nil : 10
  validate_max_errors(100)
end
# rubocop: enable GraphQL/MaxComplexitySchema
