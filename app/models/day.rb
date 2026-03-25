class Day
  include Mongoid::Document
  include Mongoid::Timestamps

  field :date, type: Date

  embeds_many :todos
  embeds_many :movies
  embeds_one :mood
  embeds_one :journal

  index({ date: 1 }, { unique: true })

  validates :date, presence: true, uniqueness: true
end
