#
# Cookbook Name:: bloomd
# Recipe:: default
#
# Copyright 2013, Calculated Content
#
# All rights reserved - Do Not Redistribute
#

include_recipe "ruby_193"

package "build-essential"
package "git"
package "scons"

user node[:bloomd][:user] do
  action :create
  system true
  shell "/bin/false"
end

directory node[:bloomd][:dir] do
  owner "root"
  mode "0755"
  action :create
end

directory node[:bloomd][:data_dir] do
  owner "bloomd"
  mode "0755"
  action :create
end

directory node[:bloomd][:log_dir] do
  mode 0755
  owner node[:bloomd][:user]
  action :create
end



git "#{Chef::Config[:file_cache_path]}/bloomd" do
  repository node[:bloomd][:git_repository]
  reference node[:bloomd][:git_revision]
  action :sync
  notifies :run, "bash[compile_bloomd]"
end


#TODO:  move blomd and set permissions
# not sure this works properly...may need extra chef commands as above

bash "compile_bloomd_source" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    scons
    cd deps/check-0.9.8/
    ./configure
    make 
    make install
    ldconfig
    cd ../..
    scons
  EOH
end


service "bloomd" do
  provider Chef::Provider::Service::Upstart
  subscribes :restart, resources(:bash => "compile_bloomd_source")
  supports :restart => true, :start => true, :stop => true
end

template "bloomd.conf" do
  path "#{node[:bloomd][:dir]}/bloomd.conf"
  source "bloomd.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "bloomd")
end

template "bloomd.upstart.conf" do
  path "/etc/init/bloomd.conf"
  source "bloomd.upstart.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "bloomd")
end

service "bloomd" do
  action [:enable, :start]
end
