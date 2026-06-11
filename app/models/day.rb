class Day
  include Mongoid::Document
  include Mongoid::Timestamps

  field :date, type: Date

  belongs_to :user
  embeds_many :todos
  embeds_many :movies
  embeds_one :mood
  embeds_one :journal

  index({ user_id: 1, date: 1 }, { unique: true })
  validates :date, presence: true, uniqueness: { scope: :user_id }
end
