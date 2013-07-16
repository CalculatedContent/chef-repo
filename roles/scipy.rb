name "scipy"
description "Simple scipy setup"
run_list "recipe[apt]","recipe[build-essential]","recipe[git]","recipe[scipy]","recipe[chef-client]"

