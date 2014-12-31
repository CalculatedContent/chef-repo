name "simple_endpoint"
description "Simple Endpoint"

run_list("recipe[apt]","recipe[build-essential]","recipe[chef-client]","recipe[git]","recipe[s3cmd]","recipe[simple_endpoint]")

