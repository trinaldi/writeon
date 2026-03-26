class Journal
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String

  embeds_many :notes
  embedded_in :day

  validates :content, presence: true
end
