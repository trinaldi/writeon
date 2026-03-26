module Mutations
  class UpdateTodo < Mutations::BaseMutation
    argument :day_id, String, required: true
    argument :done, Boolean, required: true
    argument :todo_id, String, required: true

    field :errors, [String], null: false
    field :day, Types::DayType, null: true

    def resolve(todo_id:, done:, day_id:)
      day = Day.find(day_id)
      todo = day.todos.find(todo_id)
      todo.update(done: done)

      { day: day, errors: day.errors.full_messages }
    rescue Mongoid::Errors::DocumentNotFound
      { day: nil, errors: ['Record not found'] }
    end
  end
end
