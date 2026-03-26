class Movie
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :year, type: Integer
  field :rating, type: Integer
  field :plot, type: String
  field :review, type: String
  field :watched_at, type: DateTime

  embedded_in :day

  validates :title, presence: true
  validates :year, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :watched_at, presence: true

  before_validation :set_default_watched_at

  private

  def set_default_watched_at
    return if watched_at.present?
    return unless day&.date

    self.watched_at = day.date.to_datetime
  end
end
