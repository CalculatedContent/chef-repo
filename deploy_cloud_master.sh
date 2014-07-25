#!/bin/bash
#
# Copyright (c) 2013 Charles H Martin, PhD
#  
#  Calculated Content 
#  http://calculatedcontent.com
#  charles@calculatedcontent.com
#
#TODO:  add switch / select based on location
# re-write in ruby

# http://cloud-images.ubuntu.com/releases/precise/release-20120822/

 
 #TODO:  redo this aturdya
 # damn this
 
 
AMI_ID="ami-d70c2892"
INSTANCE_TYPE="m1.small"
SECURITY_GROUPS="chefami"
RUNLIST="role[cloud_master]"

# Careful: Server name cannot have a space in it (was fine for the Chef Server, not here)
echo "knife ec2 server create -c .chef/knife.rb -N CC-Master -x ubuntu -I $AMI_ID -f $INSTANCE_TYPE -G $SECURITY_GROUPS -r $RUNLIST"
knife ec2 server create -c .chef/knife.rb -N CC-Master -x ubuntu -I $AMI_ID -f $INSTANCE_TYPE -G $SECURITY_GROUPS -r "$RUNLIST"

#TODO:  try creating new security groups
#  TODO:  try using another region, like US EAST
#  
