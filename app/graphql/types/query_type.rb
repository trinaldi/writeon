module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :days, resolver: Resolvers::DaysResolver
    field :affirmations, resolver: Resolvers::AffirmationsResolver
  end
end
