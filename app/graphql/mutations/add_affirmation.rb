module Mutations
  class AddAffirmation < Mutations::BaseMutation
    argument :author, String, required: false
    argument :body, String, required: false
    argument :show, Boolean, required: false
    field :errors, [String], null: false
    field :affirmation, Types::AffirmationType, null: true

    def resolve(body:, author: nil, show: true)
      authenticate_user!

      affirmation = current_user.affirmations.build(body:, author:, show:)
      affirmation.save
      { affirmation: affirmation.persisted? ? affirmation : nil, errors: affirmation.errors.full_messages }
    rescue StandardError => e
      { affirmation: nil, errors: [e.message] }
    end
  end
end
