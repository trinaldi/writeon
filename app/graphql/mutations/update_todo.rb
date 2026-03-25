module Mutations
  class UpdateTodo < Mutations::BaseMutation
    argument :day_id, String, required: true
    argument :done, Boolean, required: true
    argument :todo_id, String, required: true

    field :errors, [String], null: false
    field :day, Types::DayType, null: false

    def resolve(todo_id:, done:, day_id:)
      @day = Post.find(day_id)
      @todo = @day.todos.find(todo_id)

      if @todo.valid?
        @todo.update!(done: done)

        { day: @day, errors: [] }
      else
        { day: nil, errors: day.errors.full_messages }
      end
    end
  end
end
