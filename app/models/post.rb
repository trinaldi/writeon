class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  after_destroy :clear_cache
  after_save :clear_cache

  field :title, type: String
  field :body, type: String

  embeds_many :comments
  embeds_many :todos
  embeds_one :mood

  validates :title, :body, presence: true

  private

  def clear_cache
    Rails.cache.delete('all_posts')
  end
end
