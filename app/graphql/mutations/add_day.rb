module Mutations
  class AddDay < Mutations::BaseMutation
    argument :date, GraphQL::Types::ISO8601Date, required: true
    field :errors, [String], null: false
    field :day, Types::DayType, null: true

    def resolve(date:)
      day = Day.create(date: date)

      {
        day: day.persisted? ? day : nil,
        errors: day.errors.full_messages
      }
    rescue StandardError => e
      {
        day: nil,
        errors: [e.message]
      }
    end
  end
end
