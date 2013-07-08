name "xapian"
description "xapian role (installs search tool)"
run_list("recipe[apt]","recipe[build-essential]","recipe[git]","recipe[xapian]","recipe[chef-client]")


