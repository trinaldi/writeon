module Mutations
  class AddTodo < Mutations::BaseMutation
    argument :day_id, ID, required: true
    argument :done, Boolean, required: false
    argument :task, String, required: true
    field :errors, [String], null: false
    field :day, Types::DayType, null: true

    def resolve(day_id:, task:, done: false)
      day = Day.find(day_id)
      day.todos.build(task: task, done: done)
      day.save
      { day: day.persisted? ? day : nil, errors: day.errors.full_messages }
    rescue Mongoid::Errors::DocumentNotFound
      { day: nil, errors: ['Day not found'] }
    end
  end
end
