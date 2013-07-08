#!/bin/bash

AMI_ID="ami-d70c2892"  #"ami-137bcf7a"
INSTANCE_TYPE="t1.micro"
SECURITY_GROUPS="chefami"
RUNLIST="role[cloud_worker]"

knife ec2 server create -x ubuntu -I $AMI_ID  -f $INSTANCE_TYPE -G $SECURITY_GROUPS -r $RUNLIST
