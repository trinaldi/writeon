module Types
  class JournalType < BaseObject
    description 'Journal entry for a specific day'

    field :id, GraphQL::Types::ID, null: false,
                                   description: 'Unique identifier for the journal entry'

    field :content, String, null: false,
                            description: 'Main journal text for the day'

    field :notes, [NoteType], null: false,
                              description: 'Additional notes recorded throughout the day'
  end
end
