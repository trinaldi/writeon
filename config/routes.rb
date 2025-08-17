# frozen_string_literal: true

require 'graphiql/rails'

Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphql', graphql_path: '/graphql' if Rails.env.development?
  post '/graphql', to: 'graphql#execute'
  resources :posts
  resources :comments
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
