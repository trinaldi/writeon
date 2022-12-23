module Mutations
  class AddTodo < Mutations::BaseMutation
    argument :done, Boolean, required: true, description: 'Name (optional)'
    argument :post_id, String, required: true, description: 'Post ID'
    argument :task, String, required: true, description: 'Message body'

    field :errors, [String], null: false
    field :post, Types::PostType, null: false

    def resolve(post_id:, task:, done:)
      @post = Post.find(post_id)
      todo = Todo.new(done: done, task: task)
      @post.todo << todo

      if todo.valid? && @post.save
        @post.save!
        { post: @post, errors: [] }
      else
        { post: nil, errors: post.errors.full_messages }
      end
    end
  end
end