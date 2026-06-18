module Types
  class MutationType < Types::BaseObject
    field :add_affirmation, mutation: Mutations::AddAffirmation
    field :add_day, mutation: Mutations::AddDay
    field :add_mood, mutation: Mutations::AddMood
    field :add_movie, mutation: Mutations::AddMovie
    field :add_todo, mutation: Mutations::AddTodo
    field :add_user, mutation: Mutations::AddUser
    field :toggle_affirmation, mutation: Mutations::ToggleAffirmation
    field :login_user, mutation: Mutations::LoginUser
    field :update_todo, mutation: Mutations::UpdateTodo
  end
end
