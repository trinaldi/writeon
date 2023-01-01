module Mutations
  class AddMood < Mutations::BaseMutation
    argument :mood, String, required: true, description: 'Current Mood'
    argument :post_id, String, required: true, description: 'Post ID'

    field :errors, [String], null: false
    field :post, Types::PostType, null: false

    def resolve(mood:, post_id:)
      @post = Post.find(post_id)
      @mood = Mood.new(mood: mood)

      if @mood.valid?
        @post.mood = @mood

        { post: @post, errors: [] }
      else
        { post: nil, errors: post.errors.full_messages }
      end
    end
  end
end
