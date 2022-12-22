module Types
  class MutationType < Types::BaseObject
    field :add_comment, mutation: Mutations::AddComment
    field :create_post, mutation: Mutations::CreatePost
  end
end
