role_query = Chef::Search::Query.new
master_ip_address=[]

logfile = "/home/ubuntu/cc/cloud-crawler/logs/worker.log"

role_query.search(:node,'role:cloud_master') do | h|
    master_mac_address = h.ec2['network_interfaces_macs'].keys[0]
    master_public_ip_address = h.ec2['network_interfaces_macs'][master_mac_address]['public_ipv4s']
    master_ip_address = master_public_ip_address
end

puts "starting worker using #{master_ip_address} as the queue server"


# does this actually work?
# did not seem to?
# how can i fix?  i am running as sudo
execute "logs" do
    command "sudo chmod go+rwx -R /home/ubuntu/cc/cloud-crawler/logs"
    action :run
end

# should only start 1 time
#execute "runWorker" do
 #   command "cd /home/ubuntu/cc/cloud-crawler;
#    nohup sudo -E bundle exec /home/ubuntu/cc/cloud-crawler/bin/run_worker.rb -h \"#{master_ip_address}\" 2>&1 #{logfile} &" 
 #   action :run
#xsend

execute "whenever" do
    command "cd /home/ubuntu/cc/cloud-crawler; 
    sudo bundle exec whenever --set \'master_ip_address=#{master_ip_address}\' --load-file config/worker_schedule.rb --write-crontab"
    action :run
end


