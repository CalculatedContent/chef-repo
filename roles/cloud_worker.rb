name "cloud_worker"
description "Worker node"
run_list "recipe[apt]","recipe[build-essential]","recipe[git]","recipe[cloud-crawler]","recipe[chef-client]"
default_attributes({ "cloud-crawler" => { "node_type" => "worker" } })
