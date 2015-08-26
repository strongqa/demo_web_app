require 'bundler/capistrano'
require 'capistrano_colors'
require "dotenv/deployment/capistrano"

set :default_environment, {
    'PATH' => "/opt/ruby-2.2.0/bin/:$PATH"
}

set :application, 'demoapp.strongqa.com'
set :domain, 'topaz.strongqa.com'
set :deploy_to, "/opt/www/#{application}"

set :scm, :git
set :repository, 'git@github.com:strongqa/demo_web_app.git'

set :branch, ENV['BRANCH'] || 'master'
set :deploy_via, :remote_cache

set :user, 'deployer'
set :use_sudo, false
set :ssh_options, { :forward_agent => true }

role :app, domain
role :web, domain
role :db,  domain, :primary => true

set :rails_env, 'production'
set :keep_releases, 5
set :normalize_asset_timestamps, false

after 'deploy:setup' do
  run "mkdir -p #{deploy_to}/shared/var"
  run "mkdir -p #{deploy_to}/shared/config"
end

before 'deploy:assets:precompile', :roles => :app do
  run "ln -s #{deploy_to}/shared/config/database.yml #{current_release}/config/database.yml"
end

namespace :deploy do
  desc 'restart web app'
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end

  namespace :db do
    desc 'Execute db:seed'
    task :seed, :roles => :db do
      run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake db:seed"
    end

    desc 'Create Production Database'
    task :create do
      puts "\n\n=== Creating the Production Database! ===\n\n"
      run "cd #{current_path}; rake db:create RAILS_ENV=production"
    end
  end
end