class Affirmation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :author, type: String

  validates :body, presence: true
end
