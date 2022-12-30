module Mutations
  class AddComment < Mutations::BaseMutation
    argument :message, String, required: true, description: 'Message body'
    argument :name, String, required: false, description: 'Name (optional)'
    argument :post_id, String, required: true, description: 'Post ID'

    field :errors, [String], null: false
    field :post, Types::PostType, null: false

    def resolve(post_id:, message:, name: 'Tiago')
      @post = Post.find(post_id)
      @comment = Comment.new(name: name, message: message, post: @post)

      if @comment.valid? && @post.save
        @post.comment << @comment
        @post.save!
        { post: @post, errors: [] }
      else
        { post: nil, errors: post.errors.full_messages }
      end
    end
  end
end
