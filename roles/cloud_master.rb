name "cloud_master"
description "Master node"
run_list "recipe[apt]","recipe[build-essential]","recipe[git]","recipe[cloud-crawler]","recipe[chef-client]"
default_attributes({ "cloud-crawler" => { "node_type" => "master" } })

