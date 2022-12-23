class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :message, type: String

  embedded_in :post

  validates :message, presence: true
end
