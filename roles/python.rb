name "python"
description "Simple python setup"
run_list "recipe[apt]","recipe[build-essential]","recipe[git]","recipe[python]","recipe[chef-client]"

