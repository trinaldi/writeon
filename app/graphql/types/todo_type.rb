module Types
  class TodoType < BaseObject
    description 'A single task tracked for a day'

    field :id, GraphQL::Types::ID, null: false,
                                   description: 'Unique identifier for the task'

    field :done, Boolean, null: false,
                          description: 'Whether the task has been completed'

    field :task, String, null: false,
                         description: 'Description of the task'
  end
end
