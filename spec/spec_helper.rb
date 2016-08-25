require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::HTMLFormatter])
if ENV['RCOV'].to_s.casecmp('true').zero?
  SimpleCov.start do
    add_group 'Controllers', 'app/controllers'
    add_group 'Helpers', 'app/helpers'
    add_group 'Mailers', 'app/mailers'
    add_group 'Models', 'app/models'
    add_group 'Services', 'app/services'
    # add_group "Workers", "app/workers"
    add_group 'Libs', 'lib'

    [:assets, :views, :bin, :config, :db, :spec].each do |folder|
      add_filter { |src_file| src_file.filename.include?("#{folder}/") }
    end
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.order = :random
  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = false
  end
end
