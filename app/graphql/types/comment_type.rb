module Types
  class CommentType < BaseObject
    description 'Comments'
    field :id, ID, null: false, description: 'Comment ID'
    field :message, String, null: false, description: 'Comment message'
    field :name, String, null: false, description: 'Comment author'
  end
end
