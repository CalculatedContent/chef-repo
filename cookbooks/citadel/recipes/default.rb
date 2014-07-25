#
# Cookbook Name:: citadel
# Recipe:: default
#

file '/etc/secret' do
  owner 'root'
  group 'root'
  mode '600'
  content citadel['deploy_keys/secret.pem']
end

