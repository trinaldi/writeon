module Mutations
  class CreatePost < Mutations::BaseMutation
    argument :body, String, required: true
    argument :title, String, required: true

    field :errors, [String], null: false
    field :post, Types::PostType, null: false

    def resolve(title:, body:)
      @post = Post.create(title: title, body: body)

      if @post.save
        { post: @post, errors: [] }
      else
        { post: nil, errors: post.errors.full_messages }
      end
    end
  end
end
