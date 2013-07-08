name "qless_server"
description "Node that runs the job queue for distributing crawling and parsing tasks"
run_list "recipe[apt]","recipe[build-essential]","recipe[git]","recipe[qless]","recipe[chef-client]"
