require "bundler/capistrano"

set :application, "darkrails"
set :repository,  "git@github.com:darkside/darkrails.git"
set :user, "cproruby2"

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "186.202.122.168"                          # Your HTTP server, Apache/etc
role :app, "186.202.122.168"                          # This may be the same as your `Web` server
role :db,  "186.202.122.168", :primary => true        # This is where Rails migrations will run

  # SCM settings
set :scm, :git
set :branch, 'master'
set :deploy_to, "/home/cproruby2"
set :deploy_via, :remote_cache
set :keep_releases, 3
set :git_enable_submodules, true
set :rails_env, 'production' unless exists?(:rails_env)
set :use_sudo, false

# Git settings for capistrano
default_run_options[:pty]   = true
ssh_options[:forward_agent] = true


# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
