module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :posts, [Types::PostType], null: false, description: 'All posts'

    def posts
      Post.all
    end
  end
end
