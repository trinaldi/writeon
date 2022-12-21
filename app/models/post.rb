class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :body, type: String

  embeds_many :comment

  validates :title, :body, presence: true

  has_many :comments, dependent: :destroy
end
