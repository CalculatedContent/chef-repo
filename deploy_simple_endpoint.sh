#!/bin/bash
#
# Copyright (c) 2013 Charles H Martin, PhD
#  
#  Calculated Content 
#  http://calculatedcontent.com
#  charles@calculatedcontent.com
#
AMI_ID="ami-d70c2892"  #"ami-137bcf7a"
INSTANCE_TYPE="t1.micro"
SECURITY_GROUPS="chefami"


knife ec2 server create -c .chef/knife.rb -x ubuntu -I $AMI_ID  -f $INSTANCE_TYPE -G $SECURITY_GROUPS -r "role[simple_endpoint]"






