name "simple_endpoint"
description "Simple Endpoint"
run_list("recipe[apt]","recipe[build-essential]","recipe[git]","recipe[sinatra_app]","recipe[simple_endpoint]","recipe[chef-client]")

