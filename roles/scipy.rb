#
# Copyright (c) 2013 Charles H Martin, PhD
#  
#  Calculated Content 
#  http://calculatedcontent.com
#  charles@calculatedcontent.com
#
name "scipy"
description "Simple scipy setup"
run_list "recipe[apt]","recipe[build-essential]","recipe[git]","recipe[scipy]","recipe[chef-client]"

