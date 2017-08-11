# Load DSL and set up stages

# Include default deployment tasks
 
# require "capistrano/rbenv"
# require "capistrano/chruby"
#require "capistrano/bundler"
# require "capistrano/rails/assets"
# require "capistrano/rails/migrations"
# require "capistrano/passenger"

# Load DSL and set up stages
require 'capistrano/setup'
require "capistrano/rvm"
require 'capistrano/deploy'
require 'capistrano/rails'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
