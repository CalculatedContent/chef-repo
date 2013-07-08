name "simple_search"
description "Simple Search backed by Xapian"
run_list "recipe[apt]","recipe[build-essential]","recipe[git]","recipe[xapian]","recipe[sinatra_app]","recipe[simple_search]","recipe[chef-client]"

