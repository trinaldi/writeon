module Types
  class MutationType < Types::BaseObject
    # rubocop:disable GraphQL/ExtractType
    field :add_comment, mutation: Mutations::AddComment
    field :add_mood, mutation: Mutations::AddMood
    field :add_todo, mutation: Mutations::AddTodo
    field :create_post, mutation: Mutations::CreatePost
    field :update_comment, mutation: Mutations::UpdateComment
    field :update_todo, mutation: Mutations::UpdateTodo
    # rubocop:enable GraphQL/ExtractType
  end
end
