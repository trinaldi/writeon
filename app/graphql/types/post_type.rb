module Types
  module Types
    class PostType < BaseObject
    description 'Posts'
    field :id, ID, null: false, description: 'Post ID'
    field :body, String, null: false, description: 'Post contents'
    field :title, String, null: false, description: 'Post title'
    field :comments, [Types::CommentType], null: true, description: 'Post comments'
    end
  end
end
