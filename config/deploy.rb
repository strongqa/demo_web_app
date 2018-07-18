# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

# require 'bundler/capistrano'
# require 'capistrano_colors'
# require 'dotenv/deployment/capistrano'

set :application, 'demoapp.strongqa.com'
set :repo_url, 'git@github.com:strongqa/demo_web_app.git'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, proc { "/opt/www/#{fetch(:application)}/#{fetch(:stage)}" }

# Default value for :format is :airbrussh.
set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, false

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
set :default_env, { path: "/opt/ruby-2.5.1/bin/:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 1

# set :rails_env, :production

# Uncomment the following to require manually verifying the host key before first deploy.
set :ssh_options, { forward_agent: true, port: 515 }

#
# # Default value for :log_level is :debug
# set :log_level, :debug

set :rails_env, :production
set :bundle_binstubs, nil

set :puma_bind,       "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"

# namespace :deploy do
#   namespace :db do
#     desc 'Execute db:seed'
#     task :seed, roles: :db do
#       run "cd #{current_path} && RAILS_ENV=#{fetch(:rails_env)} bundle exec rake db:seed"
#     end
#
#     desc 'Create Production Database'
#     task :create do
#       Rails.logger.info "\n\n=== Creating the Production Database! ===\n\n"
#       run "cd #{current_path}; rake db:create RAILS_ENV=production"
#     end
#   end


  # after :migrate, "whenever:update_crontab" do
  #   on roles(:app) do
  #     within release_path do
  #       with rails_env: fetch(:rails_env) do
  #         execute :rake, 'cache:clear'
  #       end
  #     end
  #   end
  # end
# end

# desc "Check that we can access everything"
# task :check_write_permissions do
#   on roles(:all) do |host|
#     if test("[ -w #{fetch(:deploy_to)} ]")
#       info "#{fetch(:deploy_to)} is writable on #{host}"
#     else
#       error "#{fetch(:deploy_to)} is not writable on #{host}"
#     end
#   end
# end
# after 'deploy:setup' do
#   run "mkdir -p #{deploy_to}/shared/var"
#   run "mkdir -p #{deploy_to}/shared/config"
# end
#
# after 'deploy:update', 'deploy:cleanup'
#
# before 'deploy:assets:precompile', roles: :app do
#   run "ln -s #{deploy_to}/shared/config/database.yml #{current_release}/config/database.yml"
# end
#
# namespace :deploy do
#   desc 'restart web app'
#   task :restart, roles: :app, except: { no_release: true } do
#     run "touch #{current_path}/tmp/restart.txt"
#   end
#
#   %i[start stop].each do |t|
#     desc "#{t} task is a no-op with mod_rails"
#     task(t, roles: :app) {}
#   end
#

# end