role_query = Chef::Search::Query.new
master_ip_address=[]

role_query.search(:node,'role:cloud_master') do | h|
    master_mac_address = h.ec2['network_interfaces_macs'].keys[0]
    master_public_ip_address = h.ec2['network_interfaces_macs'][master_mac_address]['public_ipv4s']
    master_ip_address = master_public_ip_address
end

puts "starting worker using #{master_ip_address} as the queue server"


# does this actually work?
execute "logs" do
    command "sudo chmod go+rwx /home/ubuntu/apps/cloud-crawler/logs; sudo chmod go+rwx /home/ubuntu/apps/cloud-crawler/logs/worker.log"
    action :run
end

execute "runWorker" do
    command "cd /home/ubuntu/apps/cloud-crawler;
    nohup sudo -E bundle exec /home/ubuntu/apps/cloud-crawler/bin/run_worker.rb -h \"#{master_ip_address}\" &" 
    action :run
end

execute "whenever" do
    command "cd /home/ubuntu/apps/cloud-crawler; 
    sudo bundle exec whenever --set \'master_ip_address=#{master_ip_address}\' --load-file config/worker_schedule.rb --write-crontab"
    action :run
end

