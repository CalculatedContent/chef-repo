#!/bin/bash

AMI_ID="ami-d70c2892"  #"ami-137bcf7a"
INSTANCE_TYPE="t1.micro"
SECURITY_GROUPS="chefami"
RUNLIST="role[searchbox]"

knife ec2 server create -x ubuntu -I $AMI_ID  -f $INSTANCE_TYPE -G $SECURITY_GROUPS -r $RUNLIST

#apt,build-essential,git,sinatra_app,searchbox,chef-client
