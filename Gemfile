# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.0'

gem 'bootsnap', require: false
gem 'graphiql-rails'
gem 'graphql', '~> 2.0'
gem 'mongoid'
gem 'mongoid-slug'
gem 'puma', '>=6'
gem 'rails', '7.1.5.2'
gem 'simple_enum', require: 'simple_enum/mongoid'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data'

group :test do
  gem 'database_cleaner-mongoid'
  gem 'mongoid-rspec'
  gem 'timecop'
  gem 'webmock'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri windows]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-graphql', require: false
  gem 'rubocop-performance'
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec'
end

group :development do
  gem 'listen'
  gem 'pre-commit'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console'
end
