#
# Cookbook Name:: ruby_193
# Recipe:: default
#
# Copyright 2013, Calculated Content
#
# All rights reserved - Do Not Redistribute


# http://lenni.info/blog/2012/05/installing-ruby-1-9-3-on-ubuntu-12-04-precise-pengolin/


package "ruby1.9.1"
package "ruby1.9.1-dev"
package "irb1.9.1"
package "ri1.9.1"
package "rdoc1.9.1"
package "libopenssl-ruby1.9.1"
package "libssl-dev"
package "zlib1g-dev"
package "libxslt-dev"
package "libxml2-dev"

gem_package "bundler"
