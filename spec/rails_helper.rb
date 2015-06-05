ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

ActiveRecord::Migration.maintain_test_schema!

Dir[Rails.root.join("spec/support/*.rb")].each{|f| require f unless f.include?('features/')}

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.expose_dsl_globally = false
end
