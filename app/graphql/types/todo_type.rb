module Types
  class TodoType < BaseObject
    description 'Tasks to do'
    field :done, Boolean, null: false, description: 'Task status'
    field :id, ID, null: false, description: 'Todo ID'
    field :task, String, null: false, description: 'Task to do'
  end
end
