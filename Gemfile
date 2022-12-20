# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.4'

gem 'bootsnap', require: false
gem 'graphiql-rails'
gem 'graphql', '~> 2.0'
gem 'importmap-rails'
gem 'jbuilder'
gem 'mongoid'
gem 'mongoid-slug'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4'
gem 'rubocop'
gem 'rubocop-graphql'
gem 'rubocop-rails'
gem 'simple_enum', require: 'simple_enum/mongoid'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :test do
  gem 'database_cleaner-mongoid'
  gem 'mongoid-rspec'
  gem 'timecop'
  gem 'webmock'
end

group :development, :test do
  gem 'byebug'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
end

group :development do
  gem 'web-console'
end
