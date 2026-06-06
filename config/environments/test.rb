require 'active_support/core_ext/integer/time'

Rails.application.configure do
  config.middleware.use Rack::Attack
  config.cache_store = :memory_store
  config.cache_classes = true
  config.eager_load = false

  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.cache_store = :null_store

  config.action_dispatch.show_exceptions = :none
  config.action_controller.allow_forgery_protection = false

  config.active_support.deprecation = :stderr
  config.active_support.disallowed_deprecation = :raise

  config.log_level = :debug
  config.logger = ActiveSupport::Logger.new(Rails.root.join('log/test.log'))
  config.logger.formatter = ActiveSupport::Logger::Formatter.new
end
