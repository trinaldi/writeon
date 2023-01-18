module Mutations
  class UpdateComment < Mutations::BaseMutation
    argument :comment_id, String, required: true
    argument :message, String, required: true
    argument :post_id, String, required: true

    field :errors, [String], null: false
    field :post, Types::PostType, null: false

    def resolve(comment_id:, post_id:, message:)
      @post = Post.find(post_id)
      @comment = @post.comment.find(comment_id)

      if @comment.valid?
        @comment.update!(message: message)

        { post: @post, errors: [] }
      else
        { post: nil, errors: post.errors.full_messages }
      end
    end
  end
end
