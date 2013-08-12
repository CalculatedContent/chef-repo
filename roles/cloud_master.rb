#
# Copyright (c) 2013 Charles H Martin, PhD
#  
#  Calculated Content 
#  http://calculatedcontent.com
#  charles@calculatedcontent.com
#
name "cloud_master"
description "Master node"
run_list "recipe[apt]","recipe[build-essential]","recipe[git]","recipe[chef-client]","recipe[cloud-crawler]"
default_attributes({ "cloud-crawler" => { "node_type" => "master" } })

