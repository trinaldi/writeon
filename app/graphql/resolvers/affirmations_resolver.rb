module Resolvers
  class AffirmationsResolver < BaseResolver
    type [Types::AffirmationType], null: false

    argument :show, Boolean, required: false

    def resolve(show: nil)
      authenticate_user!

      scope = Affirmation.where(user: current_user)

      scope = scope.where(show: show) unless show.nil?

      scope
    end
  end
end
