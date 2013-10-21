require 'bundler/capistrano'
require 'rvm/capistrano'
require 'capistrano-unicorn'
set :rails_env, "production"
set :rvm_ruby_string, '2.0.0-p247'
set :rvm_type, :local  # Don't use system-wide RVM
#load 'config/recipes/base'
#load 'config/recipes/config'
server 'mail.interplyt.if.ua', :web, :app, :db, primary: true

set :user, 'deployer'
set :application, 'blog'
set :deploy_to, "/home/deployer/apps/blog"
set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"
#set :deploy_via, :remote_cache
#set :repository, 'https://github.com/artyomartyomov/blog_workshop'
set :deploy_via, :copy
set :copy_remote_dir, deploy_to
set :use_sudo, false
set :repository, '.'
#set :scm, :git
set :scm, :git
# set :repository, 'git@github.com:artyomartyomov/blog_workshop.git'
set :branch, 'master'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

#set :rvm_ruby_string, :local
#set :rvm_type, :system
# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
#set :rvm_ruby_string, :local # use the same ruby as used locally for deployment
#set :rvm_autolibs_flag, 'read-only' # more info: rvm help autolibs
# Unicorn tasks
#after 'deploy', 'deploy:cleanup' # keep only the last 5 releases
#after 'deploy:restart', 'unicorn:reload' # app IS NOT preloaded
#after 'deploy:restart', 'unicorn:restart'  # app preloaded
#after 'deploy', 'deploy:cleanup' # keep only the last 5 releases
##before 'deploy:restart', 'config:unicorn'
##after 'deploy:restart', 'unicorn:duplicate'
namespace :deploy do
  task :restart do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end
  task :start do
    run "bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D"
  end
  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end
end