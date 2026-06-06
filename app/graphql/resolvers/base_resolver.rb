module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    def ready?(**args)
      authenticate_user!
      super
    end

    def current_user
      context[:current_user]
    end

    def authenticate_user!
      raise GraphQL::ExecutionError, 'Not authenticated' unless current_user
    end
  end
end
