#
# Cookbook Name:: s3cmd
# Recipe:: default
#

package "git-core"
package "python-setuptools"
package "python-dateutil"

# can not use ruby gems with nativ extensions in chef_gem because ubuntu build_essentials (make) is not present yet
chef_gem "json_pure"

directory "/usr/local/share/s3cmd" do
  action :create
end

git "/usr/local/share/s3cmd" do
  # need to use the github version (1.5.0-rc1) since 1.5.0 not released yet and the latest release (1.0.1) does not support IAM access_token
  repository "git://github.com/s3tools/s3cmd.git"
#  reference node[:s3cmd][:version]
  action :sync
end

execute "build_s3cmd" do
  user "root"
  cwd "/usr/local/share/s3cmd"
  command "python setup.py install"
  action :run
end

# Link the binary to the one we built
link "/usr/local/bin/s3cmd" do
  to "/usr/local/share/s3cmd/s3cmd"
  action :create
end

# Deploy configuration for each user. Change s3cfg.erb template in your site cookbook if necessary.
# If access keys are provided in the default attributes, use them, otherwise try to get them from IAM
# AWS S3 keys are retrieved from IAM Role instance profile

node[:s3cmd][:users].each do |user| 
  
  home = user == :root ? "/root" : "/home/#{user}"

  access_key = node[:s3cmd][:aws_access_key]
  secret_key = node[:s3cmd][:aws_secret_key]

  puts "access_key #{access_key}"
  puts "secret_key #{secret_key}"
  puts node[:s3cmd].inspect

  # this just does not work
  # if access_key.empty? then
  #   # access keys not specified in attributes, get the temporary ones through IAM roles (if one was associated to the instance)
  #   require 'net/http'
  #   require 'uri'
  #   access_key = "getting IAM role"
  #   iam_role = nil

  #   begin
  #     iam_role = Net::HTTP.get_response(URI("http://169.254.169.254/latest/meta-data/iam/security-credentials/")).body
  #   rescue OpenURI::HTTPError => e
  #     puts e.inspect
  #   end

  #   if iam_role and !iam_role.empty? then
  #     access_key = "getting IAM role keys"
  #     require 'json/pure'
  #     begin
  #       credentials = JSON.parse(Net::HTTP.get_response(URI("http://169.254.169.254/latest/meta-data/iam/security-credentials/#{iam_role}")).body)
  #       access_key = credentials['AccessKeyId']
  #       secret_key = credentials['SecretAccessKey']
  #       access_token = credentials['Token']
  #     rescue OpenURI::HTTPError => e
  #       puts e.inspect
  #     end
  #   end
  # end

  template "#{home}/.s3cfg" do
      source "s3cfg.erb"
      variables({
        :access_key => access_key,
        :secret_key => secret_key
#        :access_token => access_token,
      })
      mode 0600
  end  
  
end
