#!/bin/bash

#TODO:  add switch / select based on location
# re-write in ruby

# http://cloud-images.ubuntu.com/releases/precise/release-20120822/

 
 #TODO:  redo this aturdya
 # damn this
 
 
AMI_ID="ami-d70c2892"
INSTANCE_TYPE="m1.small"
SECURITY_GROUPS="chefami"
RUNLIST="role[cloud_master]"

echo "knife ec2 server create -x ubuntu -I $AMI_ID  -f $INSTANCE_TYPE -G $SECURITY_GROUPS -r \"$RUNLIST\""
knife ec2 server create -x ubuntu -I $AMI_ID  -f $INSTANCE_TYPE -G $SECURITY_GROUPS -r "$RUNLIST"

#TODO:  try creating new security groups
#  TODO:  try using another region, like US EAST
#  