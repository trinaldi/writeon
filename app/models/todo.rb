class Todo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :done, type: Boolean, default: false
  field :task, type: String

  validates :done, :task, presence: true

  embedded_in :post
end
