require File.expand_path('config/application', __dir__)

Rails.application.load_tasks

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new do |task|
    task.requires << 'rubocop-rails'
    task.requires << 'rubocop-rspec'
    task.requires << 'rubocop-factory_bot'
  end
rescue LoadError
  nil
end
