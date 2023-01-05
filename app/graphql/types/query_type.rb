module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :month_prior_posts, [Types::PostType], null: false,
                                                 description: 'Posts from a month ago'
    field :posts, [Types::PostType], null: false, description: 'All posts'

    def posts
      Post.all
    end

    def month_prior_posts
      Post.where(created_at: { '$gte': 1.month.ago }).order(created_at: 1)
    end
  end
end
