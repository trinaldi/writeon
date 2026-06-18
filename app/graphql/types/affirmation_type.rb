module Types
  class AffirmationType < BaseObject
    description 'A single affirmation entry'

    field :id, GraphQL::Types::ID, null: false,
                                   description: 'Unique identifier for the affirmation'

    field :body, String, null: true, description: 'Body or content of the affirmation'

    field :author, String, null: true, description: 'Author of such affirmation'
  end
end
