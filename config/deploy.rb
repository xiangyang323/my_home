# config valid only for current version of Capistrano
lock "3.8.1"

set :application, "my_home"
set :repo_url, "git@github.com:xiangyang323/my_home.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, 'master'

set :rvm_type, :user
set :rvm_ruby_version, 'ruby-2.3.3@my_home'
# set :rvm_binary, '~/.rvm/bin/rvm'
set :rvm_binary, '/home/xiangyang/.rvm/bin/rvm'
set :deploy_via, :remote_cache

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
set :deploy_to, "/home/xiangyang/#{fetch(:application)}"
set :current, "#{fetch(:deploy_to)}/current"

#set :use_sudo, true

#set :user, "xiang"

set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, "config/database.yml", "config/secrets.yml"
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_files, fetch(:linked_files, []).push('config/database.yml', "config/secrets.yml")

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "cd #{current_path}; RAILS_ENV=#{fetch(:stage)} #{fetch(:rvm_binary)} #{fetch(:rvm_ruby_version)} do bundle install"
      execute "cd #{current_path}; RAILS_ENV=#{fetch(:stage)} #{fetch(:rvm_binary)} #{fetch(:rvm_ruby_version)} do bundle exec rake db:migrate"
      execute "cd #{current_path}; RAILS_ENV=#{fetch(:stage)} #{fetch(:rvm_binary)} #{fetch(:rvm_ruby_version)} do bundle exec rake assets:precompile"

      execute "touch #{fetch(:current)}/tmp/restart.txt"
    end
  end

  # desc 'Restart application'
  # task :restart do
  #   on roles(:app), in: :sequence, wait: 5 do
  #     # Your restart mechanism here, for example:

  #     # execute "cd #{current_path}; RAILS_ENV=#{fetch(:stage)} #{fetch(:rvm_binary)} #{fetch(:rvm_ruby_version)} do bundle install"
  #     # #
  #     # execute "cd #{current_path}; RAILS_ENV=#{fetch(:stage)} #{fetch(:rvm_binary)} #{fetch(:rvm_ruby_version)} do bundle exec rake db:migrate"
  #     # #
  #     # execute "cd #{current_path}; RAILS_ENV=#{fetch(:stage)} #{fetch(:rvm_binary)} #{fetch(:rvm_ruby_version)} do bundle exec rake assets:precompile"
  #     #
  #     #execute "cd #{current_path}; RAILS_ENV=#{fetch(:stage)} #{fetch(:rvm_binary)} #{fetch(:rvm_ruby_version)} do bundle exec ruby bin/resque_mailer restart"

  #     execute :touch, release_path.join('tmp/restart.txt')
  #   end
  # end

  #after :publishing, :restart

  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end

  # task :generate_500_html do
  #   on roles(:web) do |host|
  #     public_500_html = File.join(release_path, "public/500.html")
  #     execute :curl, "-k", "https://#{host.hostname}/500", "> #{public_500_html}"
  #   end
  # end
  # after :published, :generate_500_html

  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end
