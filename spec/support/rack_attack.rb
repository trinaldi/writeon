RSpec.configure do |config|
  config.before(:each, type: :request) do
    Rack::Attack.cache.store.clear
  end
end
