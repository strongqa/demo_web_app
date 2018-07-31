# config valid for current version and patch releases of Capistrano
lock '~> 3.11.0'

# require 'bundler/capistrano'
# require 'capistrano_colors'
# require 'dotenv/deployment/capistrano'

set :application, 'demoapp.strongqa.com'
set :repo_url, 'https://github.com/strongqa/demo_web_app.git'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, proc { "/opt/www/#{fetch(:application)}/#{fetch(:stage)}" }

# Default value for :format is :airbrussh.
set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, false

# Default value for :linked_files is []
# append :linked_files, "config/database.yml
set :linked_files, fetch(:linked_files, []).push('.env')

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
set :default_env, path: '/opt/ruby-2.5.1/bin/:$PATH'

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 1

# set :rails_env, :production

# Uncomment the following to require manually verifying the host key before first deploy.
set :ssh_options, forward_agent: true, port: 515

#
# # Default value for :log_level is :debug
# set :log_level, :debug

set :rails_env, :production
set :bundle_binstubs, nil

set :puma_bind,       "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"

namespace :deploy do
  desc 'Runs rake db:seed for SeedMigrations data'
  task :seed => [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  after 'deploy:migrate', 'deploy:seed'
end
