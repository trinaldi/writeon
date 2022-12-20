module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :comments, [Types::CommentType], null: false
    field :posts, [Types::PostType], null: false
    field :post, Types::PostType, null: false do
      argument :id, ID, required: true
    end

    def comments
      Comment.all
    end

    def posts
      Post.all
    end

    def post(id:)
      Post.find(id)
    end
  end
end
