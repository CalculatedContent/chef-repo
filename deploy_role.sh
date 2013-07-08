#!/bin/bash

AMI_ID="ami-d70c2892"  #"ami-137bcf7a"
INSTANCE_TYPE="t1.micro"
SECURITY_GROUPS="chefami"
RECIPE=$1
RUNLIST="role[$1]"

knife ec2 server create -x ubuntu -I $AMI_ID  -f $INSTANCE_TYPE -G $SECURITY_GROUPS -r $RUNLIST

echo "hack for now..sleeping for 2m..."

sleep 2m
node=`knife ec2 server list | awk  '{print $1}' | tail -1`
ip_address=`knife ec2 server list | awk  '{print $3}' | tail -1`
run_list=`cat roles/$RECIPE.rb | grep run_list | awk '{print $2}' | sed -e 's/\"//g' `

echo "node $node   ip $ip_address "
echo "run_list  $run_list"
knife node run_list add $node "$run_list"

echo "done... logging in and executing chef-client"
ssh -i ~/.ssh/cms_aws_3.pem ubuntu@$ip_address nohup 'sudo chef-client &'


