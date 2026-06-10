module Mutations
  class LoginUser < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :user_id, String, null: true

    def resolve(email:, password:)
      user = User.where(email: email.downcase.strip).first

      return auth_payload(user) if user&.authenticate(password)

      raise GraphQL::ExecutionError, 'Invalid email or password'
    end

    private

    def find_user(email)
      User.find_by(email: email.downcase.strip)
    end

    def auth_payload(user)
      {
        token: user.generate_auth_token,
        user_id: user.id.to_s
      }
    end
  end
end

