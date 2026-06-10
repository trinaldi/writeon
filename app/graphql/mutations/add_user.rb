module Mutations
  class AddUser < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :errors, [String], null: false
    field :user, Types::UserType, null: true
    field :token, String, null: true

    def resolve(email:, password:)
      user = User.create(email: email, password: password)

      {
        user: user.persisted? ? user : nil,
        errors: user.errors.full_messages
      }
    rescue StandardError => e
      {
        user: nil,
        errors: [e.message]
      }
    end
  end
end
