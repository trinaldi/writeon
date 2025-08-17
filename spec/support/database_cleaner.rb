RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner[:mongoid].clean
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
