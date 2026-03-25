module Types
  class MutationType < Types::BaseObject
    field :add_mood, mutation: Mutations::AddMood
    field :add_day, mutation: Mutations::AddDay
    field :add_todo, mutation: Mutations::AddTodo
    field :update_todo, mutation: Mutations::UpdateTodo
  end
end
