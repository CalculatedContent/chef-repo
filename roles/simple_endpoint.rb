name "simple_endpoint"
description "Simple Endpoint"

run_list("recipe[apt]","recipe[build-essential]","recipe[git]","recipe[simple_endpoint]","recipe[chef-client]")

