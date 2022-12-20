module Types
  class CommentType < Types::BaseObject
    description 'Comments'
    field :id, ID, null: false, description: 'Comment ID'
    field :name, String, null: false, description: 'Comment author'
    field :message, String, null: false, description: 'Comment message'
  end
end
