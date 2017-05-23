RSpec.configure do |config|
  DatabaseCleaner.strategy = :transaction

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
