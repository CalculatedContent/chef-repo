#
# Copyright (c) 2013 Charles H Martin, PhD
#  
#  Calculated Content 
#  http://calculatedcontent.com
#  charles@calculatedcontent.com
#
name "qless_server"
description "Node that runs the job queue for distributing crawling and parsing tasks"
run_list "recipe[apt]","recipe[build-essential]","recipe[git]","recipe[qless]","recipe[chef-client]"
