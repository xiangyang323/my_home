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
set :rvm_binary, '/usr/local/rvm/bin/rvm'

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
set :deploy_to, "/home/xiang/#{fetch(:application)}"
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
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do
  # desc 'Initial Deploy'
  # task :initial do
  #   on roles(:app, :batch) do
  #     execute "gem install bundle"
  #   end
  # end 	

  before :updated, :gems_install do
    # on roles(:batch) do
    #   within release_path do
    #     execute :bundle, :exec, :rake, "db:migrate"
    #   end
    # end

    # on roles(:app, :batch) do
    #   within release_path do
    #     execute :bundle, :exec, :rake, "assets:precompile"
    #   end
    # end
  end

  after :finished, :init do
    on roles(:app, :batch) do
      within release_path do
        #没有使用本地mp4地址
        #execute :sudo, "ln -s /home/kabucom/kabu_video/rakurakuBB_20160926.mp4 /home/kabucom/kabucom_ipo/current/public/kabu_ipo2"
      	#execute :sudo, "/opt/nginx-1.9.4-passenger-5.0.20/sbin/nginx -s reload"
        execute "touch #{fetch(:current)}/tmp/restart.txt"
      end
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

end
