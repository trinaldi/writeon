module Mutations
  class AddDay < Mutations::BaseMutation
    argument :date, GraphQL::Types::ISO8601Date, required: true
    field :errors, [String], null: false
    field :day, Types::DayType, null: true

    def resolve(date:)
      {
        day: nil,
        errors: ["cheguei aqui"]
      }
    end
  end
end
