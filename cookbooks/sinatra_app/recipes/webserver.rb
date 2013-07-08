#
# Cookbook Name:: sinatra-app
# Recipe:: default
#
# Copyright 2013, Calculated Content
#
# All rights reserved - Do Not Redistribute

include_recipe 'git'
include_recipe "ruby_193"

include_recipe 'apache2'
include_recipe 'passenger_apache2'

include_recipe 's3cmd'
include_recipe 'redisio'
include_recipe 'redisio::install'
include_recipe 'redisio::enable'


name = node[:sinatra_app][:name]
# Create vhost

web_app name do
  server_name name
  docroot node[:sinatra_app][:docroot]
  template "sinatra_app.conf.erb"
  log_dir node[:apache][:log_dir]
  rack_env "production"
end

# Set file and directory perimissions
# might destroy apps -- be careful
directory node[:sinatra_app][:deploy_dir] do
  owner node[:apache][:user]
  group node[:apache][:user]
  action :create 
  recursive true
end


gem_package "sinatra" do
  action :install
end

gem_package "whenever" do
  action :install
end

