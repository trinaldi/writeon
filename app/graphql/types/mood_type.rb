module Types
  class MoodType < BaseObject
    description 'Mood'
    field :id, ID, null: false, description: 'Mood ID'
    field :mood, String, null: false, description: 'Current Mood'
  end
end
