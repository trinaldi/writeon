module Mutations
  class ToggleAffirmation < Mutations::BaseMutation
    argument :affirmation_id, String, required: true

    field :errors, [String], null: false
    field :affirmation, Types::AffirmationType, null: true

    def resolve(affirmation_id:)
      authenticate_user!

      affirmation = current_user.affirmations.find(affirmation_id)

      success = affirmation.update(show: !affirmation.show)

      { affirmation: affirmation, errors: success ? [] : affirmation.errors.full_messages }
    rescue Mongoid::Errors::DocumentNotFound
      { affirmation: nil, errors: ['Record not found'] }
    end
  end
end
