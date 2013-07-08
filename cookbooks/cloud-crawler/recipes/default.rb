#
# Cookbook Name:: cloud-crawler
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

case node['cloud-crawler']['node_type']
when 'master'
  include_recipe "cloud-crawler::master"
when 'worker'
  include_recipe "cloud-crawler::worker"
else
  raise "Unsupported cloud-crawler node : #{node['cloud-crawler']['node_type']}. Supported: master or worker."
end




