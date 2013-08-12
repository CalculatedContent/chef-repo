#
# Copyright (c) 2013 Charles H Martin, PhD
#  
#  Calculated Content 
#  http://calculatedcontent.com
#  charles@calculatedcontent.com
#
name "python"
description "Simple python setup"
run_list "recipe[apt]","recipe[build-essential]","recipe[git]","recipe[python]","recipe[chef-client]"

