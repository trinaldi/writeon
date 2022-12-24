class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :body, type: String

  embeds_many :comment
  embeds_many :todo

  validates :comment, :todo, presence: true
  validates :title, :body, presence: true
end
