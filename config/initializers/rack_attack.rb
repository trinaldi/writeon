Rack::Attack.cache.store = ActiveSupport::Cache.lookup_store(:memory_store)

Rack::Attack.throttle('graphql/ip', limit: 60, period: 1.minute) do |req|
  req.ip if req.post? && req.path == '/graphql'
end
