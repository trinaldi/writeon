module Types
  class MutationType < Types::BaseObject
    field :add_comment, mutation: Mutations::AddComment
    field :add_mood, mutation: Mutations::AddMood
    field :add_post, mutation: Mutations::AddPost
    field :add_todo, mutation: Mutations::AddTodo
    field :update_comment, mutation: Mutations::UpdateComment
    field :update_todo, mutation: Mutations::UpdateTodo
    # rubocop:enable GraphQL/ExtractType
  end
end
