#
# Cookbook Name:: qless
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

include_recipe 'redisio'
include_recipe 'redisio::install'
include_recipe 'redisio::enable'



gem_package "sinatra"
gem_package "haml"
gem_package "will_paginate"
gem_package "active_support"
gem_package "vegas"
gem_package "qless"

git "/home/ubuntu/qless" do
    repository "https://github.com/trtg/qless.git"
    reference "master"
    action :sync
end

git "/home/ubuntu/qless-py" do
    repository "https://github.com/trtg/qless-py.git"
    reference "master"
    action :sync
end

execute "qlessPyInstall" do
    command "cd /home/ubuntu/qless-py/;
    sudo python setup.py install"
    action :run
end

