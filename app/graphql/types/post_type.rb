module Types
  class Types::PostType < BaseObject
    description 'Posts'
    field :id, ID, null: false, description: 'Post ID'
    field :title, String, null: false, description: 'Post title'
    field :body, String, null: false, description: 'Post contents'
    field :comments, [Types::CommentType], null: true, description: 'Post comments'
  end
end
