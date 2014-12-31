#!/bin/bash
#
# Copyright (c) 2013 Charles H Martin, PhD
#  
#  Calculated Content 
#  http://calculatedcontent.com
#  charles@calculatedcontent.com
#
NAME=$1
AMI_ID="ami-a26265e7"  
                        
INSTANCE_TYPE="t1.micro"
SECURITY_GROUPS="chefami"

knife ec2 server create -c .chef/knife.rb -N $NAME -x ubuntu -I $AMI_ID -f $INSTANCE_TYPE -G $SECURITY_GROUPS 

