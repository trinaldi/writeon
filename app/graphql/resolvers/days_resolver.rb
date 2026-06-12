module Resolvers
  class DaysResolver < BaseResolver
    type [Types::DayType], null: false

    def resolve
      authenticate_user!
      Day.all.to_a
    end
  end
end
