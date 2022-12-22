class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :body, type: String

  validates :title, :body, presence: true

  embeds_many :comment
end
