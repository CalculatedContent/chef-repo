include_recipe "cloud-crawler::crawler"
include_recipe "cloud-crawler::monitor"


execute "whenever" do
    command "cd /home/ubuntu/apps/cloud-crawler; 
    sudo bundle exec whenever --load-file config/master_schedule.rb --write-crontab"
    action :run
end

