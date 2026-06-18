module Resolvers
  class AffirmationsResolver < BaseResolver
    type [Types::AffirmationType], null: false

    def resolve
      authenticate_user!
      
      Affirmation.where(user: current_user, show: true)
    end
  end
end
