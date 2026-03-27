# frozen_string_literal: true

require 'graphiql/rails'

Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?
  post '/graphql', to: 'graphql#execute'

  get '/debug' => 'debug#index'
end
