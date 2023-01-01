module Types
  class PostType < BaseObject
    description 'Posts'
    field :body, String, null: false, description: 'Post contents'
    field :comment, [CommentType], null: true, description: 'Post comments'
    field :id, ID, null: false, description: 'Post ID'
    field :mood, MoodType, null: true, description: 'Current Mood'
    field :title, String, null: false, description: 'Post title'
    field :todo, [TodoType], null: true, description: 'Post to dos'
  end
end
