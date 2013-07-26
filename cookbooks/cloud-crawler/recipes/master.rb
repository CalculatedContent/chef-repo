include_recipe "cloud-crawler::monitor"
include_recipe "cloud-crawler::crawler"

execute "whenever" do
    command "cd /home/ubuntu/cc/cloud-crawler; 
    sudo bundle exec whenever --load-file config/master_schedule.rb --write-crontab"
    action :run
end

