RSpec.configure do |config|
  config.before(:suite) do
    Mongoid.purge!
  end

  config.after do
    Mongoid.purge!
  end
end
