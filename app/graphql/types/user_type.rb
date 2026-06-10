module Types
  class UserType < BaseObject
    description 'The user'

    field :id, GraphQL::Types::ID, null: false,
                                   description: 'Unique identifier for the user'

    field :token, String, null: false,
                          description: 'JWT Token generated'
  end
end
