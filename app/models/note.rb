class Note
  include Mongoid::Document
  include Mongoid::Timestamps
  before_create :set_happened_at

  field :happened_at, type: Time
  field :content, type: String

  embedded_in :journal

  validates :content, presence: true

  private

  def set_happened_at
    self.happened_at ||= Time.zone.now
  end
end
