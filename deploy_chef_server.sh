#!/bin/bash 
#Pre-requisites:
#You must create a security group with a rule allowing port 443 (HTTPS) and port 22(SSH) as this is 
#what chef server >=11.x now uses, in the script below that security group is called chef_server_group
#the security group can be created from the AWS web console or using the amazon supplied ec2-api-tools

USER=$CHEF_USER
KEY_NAME=$CHEF_KEY #the name shown under "Key Pairs" in AWS console
KEY_FILE=$CHEF_PEM #the path to your AWS key

SECURITY_GROUPS="chefami" #group you created with port 22 and 443 open
INSTANCE_TYPE="m1.small" #Note that at least a small is recommended currently
AMI_ID=$CHEF_AMI_ID #AMI you wish to use- must be available in your region
NODE_NAME="chefami" #A descriptive name that will appear in knife ec2 server list output

echo "NOTE: Pay attention as this script runs- you will be prompted to enter a password at one point"

echo $AMI_ID

#see here for how to create a security group in ruby:
#https://github.com/fnichol/knife-server/blob/master/lib/knife/server/ec2_security_group.rb
#knife server plugin would allow us to do everything with just this command, but it doesn't work, I've filed an issue on github already
#knife server bootstrap ec2 -I $AMI_ID -k $KEY_NAME --ssh-key $KEY_FILE --ssh-user ubuntu -f $INSTANCE_TYPE --node-name $NODE_NAME
if [ ! -d .chef ]
then mkdir .chef
else cp -r .chef .chef.bak
    rm -rf .chef
    echo "WARNING: your existing .chef has been moved to .chef.bak"
    mkdir .chef
fi

if [ -f instance_info ]
then
    rm "instance_info"
fi
#
##Create an instance on which to run chef server and store the generated public IP in a hacky way
knife ec2 server create -x ubuntu -I $AMI_ID  -f $INSTANCE_TYPE -k $KEY_NAME --ssh-key $KEY_FILE  -G $SECURITY_GROUPS | tee instance_info
ip_address=`cat instance_info | awk -F : '/Public IP/{gsub(/[ \t]/,"",$2);print $2 }' | tail -n 1`
host_name=`cat instance_info | awk -F : '/Public DNS/{gsub(/[ \t]/,"",$2);print $2 }' | tail -n 1`
echo "public host name is $host_name" 

if [ -f instance_info ]
then
    rm "instance_info"
else
    echo "There was a problem creating your instance, exiting now"
    exit
fi
#echo "ip address is$ip_address"

#set the FQDN to the amazon public DNS name- if you don't do this knife cookbook will try to reference the internal DNS name
#NOTE: the FQDN must be set properly before you do chef-server-ctl reconfigure
#disable StrictHostKeyChecking on the first connection attempt to avoid (yes/no) prompt
ssh -oStrictHostKeyChecking=no -i $KEY_FILE ubuntu@$ip_address "echo $host_name > /etc/hostname" 

ssh -i $KEY_FILE ubuntu@$ip_address "sudo hostname -F /etc/hostname"
ssh -i $KEY_FILE ubuntu@$ip_address "sudo echo $ip_address $host_name >> /etc/hosts"

#Download chef server on your new instance and install/test it
ssh -i $KEY_FILE ubuntu@$ip_address 'wget https://opscode-omnitruck-release.s3.amazonaws.com/ubuntu/12.04/x86_64/chef-server_11.0.6-1.ubuntu.12.04_amd64.deb' 
ssh -i $KEY_FILE ubuntu@$ip_address 'sudo dpkg -i chef-server_11.0.6-1.ubuntu.12.04_amd64.deb'
ssh -i $KEY_FILE ubuntu@$ip_address 'sudo chef-server-ctl reconfigure'
ssh -i $KEY_FILE ubuntu@$ip_address 'sudo chef-server-ctl test'

#copy the keys you need and change ownership so ubuntu can access them since
#you cannot directly SSH as root
ssh -i $KEY_FILE ubuntu@$ip_address 'sudo cp /etc/chef-server/admin.pem /home/ubuntu/'
ssh -i $KEY_FILE ubuntu@$ip_address 'sudo cp /etc/chef-server/chef-validator.pem /home/ubuntu/'
ssh -i $KEY_FILE ubuntu@$ip_address 'sudo chown ubuntu /home/ubuntu/admin.pem'
ssh -i $KEY_FILE ubuntu@$ip_address 'sudo chown ubuntu /home/ubuntu/chef-validator.pem'

scp -i $KEY_FILE ubuntu@$ip_address:/home/ubuntu/admin.pem .chef/
scp -i $KEY_FILE ubuntu@$ip_address:/home/ubuntu/chef-validator.pem .chef/

#clean up the temp copies of the keys
ssh -i $KEY_FILE ubuntu@$ip_address 'rm /home/ubuntu/admin.pem'
ssh -i $KEY_FILE ubuntu@$ip_address 'rm /home/ubuntu/chef-validator.pem'

#this will create a new knife.rb and "node_name".pem
touch .chef/knife.rb
echo "The password you enter cannot be empty and must be at least 6 characters long"
knife configure  -i -u $USER -y -s "https://$ip_address" -k ".chef/$USER.pem"  --admin-client-key .chef/admin.pem --admin-client-name "admin" --validation-client-name chef-validator --validation-key .chef/chef-validator.pem --repository . -c .chef/knife.rb

#upload all existing cookbooks and roles
knife cookbook upload -a
for z in roles/*rb; do knife role from file $z;done

echo "knife[:aws_ssh_key_id] = \"$KEY_NAME\"">> .chef/knife.rb
echo "knife[:identity_file] =\"$CHEF_PEM\"" >> .chef/knife.rb
echo "knife[:aws_access_key_id]=\" #{ENV['AWS_ACCESS_KEY_ID']}\" "
echo "knife[:aws_secret_access_key]=\"#{ENV['AWS_SECRET_ACCESS_KEY']}\" "
echo "knife[:availability_zone]=\"#{ENV['EC2_AVAILABILITY_ZONE']}\" "
echo "knife[:region]=\"#{ENV['EC2_REGION']}\" "



echo "After fixing the lines above you should be able to bootstrap new nodes with knife ec2 server create"
echo "Login to the chef server webUI at https://$ip_address using username admin and password p@ssw0rd1 and immediately change the password"
echo "You can also login using $USER as your username and the password you entered earlier"

