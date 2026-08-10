module Mutations
  class AddJournal < Mutations::BaseMutation
    argument :content, String, required: true
    argument :day_id, String, required: true, description: 'Day ID'

    field :errors, [String], null: false
    field :journal, Types::JournalType, null: true

    def resolve(day_id:, content:)
      authenticate_user!

      day = Day.where(user: current_user).find(day_id)
      day.build_journal(content: content)
      day.save!
      { journal: day.persisted? ? day.journal : nil, errors: day.journal.errors.full_messages }
    rescue Mongoid::Errors::DocumentNotFound
      { journal: nil, errors: ['Day not found'] }
    end
  end
end
