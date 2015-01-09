#!/bin/bash
#
# Copyright (c) 2015 Charles H Martin, PhD
#  
#  Calculated Content 
#  http://calculatedcontent.com
#  charles@calculatedcontent.com
#

AMI_ID="ami-a26265e7" 
INSTANCE_TYPE="t1.micro"
SECURITY_GROUPS="chefami"

# 1.  create
# 2.  ssh private key to server .. need ssh key
# 3.  add private endpoint role, and rerun
knife ec2 server create -c .chef/knife.rb -N privateEndpoint -x ubuntu -I $AMI_ID -f $INSTANCE_TYPE -G $SECURITY_GROUPS 

# knife node role_list add private_endpoint
# ssh in, run sudo chef-client

