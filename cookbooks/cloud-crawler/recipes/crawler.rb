#
# Cookbook Name:: cloud-crawler
# Recipe:: crawler
#
# Copyright 2013, Calculated Content
#
# All rights reserved - Do Not Redistribute
include_recipe 'git'
include_recipe "ruby_193"

include_recipe 's3cmd'
include_recipe 'redisio'
include_recipe 'redisio::install'
include_recipe 'redisio::enable'

gem_package "bundler"

git "/home/ubuntu/apps" do
    repository "https://github.com/CalculatedContent/cloud-crawler.git"
    reference "master"
    action :sync
end

execute "crawler_install" do
    command "cd /home/ubuntu/apps/cloud-crawler;
    bundle install;gem build cloud-crawler.gemspec; gem install cloud-crawler*.gem"
    action :run
end


