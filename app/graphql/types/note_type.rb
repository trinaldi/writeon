module Types
  class NoteType < BaseObject
    description 'A note written within a journal entry'

    field :id, GraphQL::Types::ID, null: false,
                                   description: 'Unique identifier for the note'

    field :content, String, null: false,
                            description: 'Text content of the note'

    field :happened_at, GraphQL::Types::ISO8601DateTime, null: false,
                                                         description: 'Date and time when the noted event happened'
  end
end
