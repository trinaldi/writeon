module Mutations
  class AddTodo < Mutations::BaseMutation
    argument :day_id, ID, required: true
    argument :done, Boolean, required: false
    argument :task, String, required: true

    field :errors, [String], null: false
    field :todo, Types::TodoType, null: true

    def resolve(day_id:, task:, done: false)
      day = Day.find(day_id)
      todo = day.todos.build(task: task, done: done)

      { todo: todo.persisted? ? todo : (todo.save && todo), errors: todo.errors.full_messages }
    rescue Mongoid::Errors::DocumentNotFound
      { todo: nil, errors: ['Day not found'] }
    end
  end
end
