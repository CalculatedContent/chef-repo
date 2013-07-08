#
# Cookbook Name:: sinatra-app
# Recipe:: default
#
# Copyright 2013, Calculated Content
#
# All rights reserved - Do Not Redistribute

include_recipe "sinatra_app::webserver"
gem_package "bundler"


# Use the magical deploy_resource module in chef
deploy_revision node[:sinatra_app][:deploy_dir] do
  scm_provider Chef::Provider::Git
  repo node[:sinatra_app][:repository]
  revision node[:sinatra_app][:branch]

  migrate false
  environment "production"
  
  symlink_before_migrate.clear
  create_dirs_before_symlink ["pids", "logs", "system", "tmp"]
  purge_before_symlink.clear
  symlinks.clear
  
  user node[:apache][:user]
  group node[:apache][:group]

  before_restart do
    current_release_directory = release_path
    running_deploy_user = new_resource.user

    execute "before_restart" do
     cwd current_release_directory
     user running_deploy_user
     command "bundle install --quiet --deployment; touch logs/sinatra.log  "
     action :run
    end
  end

  action :deploy
  restart_command restart_command "touch tmp/restart.txt"
  notifies :restart, "service[apache2]"
  
end

