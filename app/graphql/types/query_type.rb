module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :comments, [Types::CommentType], null: false
    field :posts, [Types::PostType], null: false
    def comments
      Comment.all
    end

    def posts
      Post.all
    end
  end
end
