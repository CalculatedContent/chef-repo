#
# Cookbook Name:: sinatra-app
# Recipe:: default
#
# Copyright 2013, Calculated Content
#
# All rights reserved - Do Not Redistribute

include_recipe "sinatra_app::webserver"
gem_package "bundler"

use_ssh = false
if !node['sinatra_app']['deploy_key'].empty? then
  use_ssh = true
end

if use_ssh then
 
 
 # citadel not working
 # deploy_key_path = "#{node[:sinatra_app][:deploy_dir]}/#{node['sinatra_app']['deploy_key']}"

 # file deploy_key_path do
 #   content citadel["#{node['sinatra_app']['deploy_key']}"]
 #   user node[:apache][:user]
 #   group node[:apache][:group]
 #   mode '600'
 # end

  template "git_ssh_wrapper" do
      path "#{node[:sinatra_app][:deploy_dir]}/git_ssh_wrapper.sh"
      source "git_ssh_wrapper.sh.erb"
      variables({
        :deploy_key => deploy_key_path,
      })
      user node[:apache][:user]
      group node[:apache][:group]
      mode 0700
  end
end

# Use the magical deploy_resource module in chef
deploy_revision node[:sinatra_app][:deploy_dir] do
  scm_provider Chef::Provider::Git
  repo node[:sinatra_app][:repository]
  revision node[:sinatra_app][:branch]

  if use_ssh then
    git_ssh_wrapper "#{node[:sinatra_app][:deploy_dir]}/git_ssh_wrapper.sh"
  end

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

