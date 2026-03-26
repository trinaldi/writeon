Rack::Attack.throttle('graphql/ip', limit: 60, period: 1.minute) do |req|
  req.ip if req.path == '/graphql'
end
