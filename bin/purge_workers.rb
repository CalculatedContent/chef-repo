#!/usr/bin/env bash

for z in `knife ec2 server list | grep micro | awk '{print $1}'` 
do 
  echo $z 
  knife ec2 server delete --purge $z
  echo "-----"
done



