require 'database_cleaner'

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:example) do |example|
    if example.metadata[:js] || example.metadata[:truncation]
      DatabaseCleaner.strategy = :transaction
    else
      DatabaseCleaner.strategy = :transaction
    end
    DatabaseCleaner.start
  end

  config.after(:example) do
    DatabaseCleaner.clean
  end

end