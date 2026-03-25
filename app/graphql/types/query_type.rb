module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :days, [Types::DayType], null: false, description: 'All days'

    def days
      Day.all.to_a
    end
  end
end
