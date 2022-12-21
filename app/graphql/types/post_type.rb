module Types
  class PostType < BaseObject
    description 'Posts'
    field :body, String, null: false, description: 'Post contents'
    field :comments, [CommentType], null: true, description: 'Post comments'
    field :id, ID, null: false, description: 'Post ID'
    field :title, String, null: false, description: 'Post title'
  end
end
