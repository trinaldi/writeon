module Mutations
  class UpdateTodo < Mutations::BaseMutation
    argument :done, Boolean, required: true
    argument :post_id, String, required: true
    argument :todo_id, String, required: true

    field :errors, [String], null: false
    field :post, Types::PostType, null: false

    def resolve(todo_id:, done:, post_id:)
      @post = Post.find(post_id)
      @todo = @post.todo.find(todo_id)

      if @todo.save
        @todo.update!(done: done)
        { post: @post, errors: [] }
      else
        { post: nil, errors: @post.errors.full_messages }
      end
    end
  end
end
