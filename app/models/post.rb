class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :body, type: String

  embeds_many :comments
  embeds_many :todos
  embeds_one :mood

  validates :title, :body, presence: true
end
