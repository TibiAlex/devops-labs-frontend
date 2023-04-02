#!/bin/bash
ips=""
for i in $(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name group_of_instances | grep -i instanceid  | awk '{ print $2}' | cut -d',' -f1| sed -e 's/"//g'); do
    ip=$(aws ec2 describe-instances --instance-ids $i | grep -i PublicIpAddress | awk '{ print $2 }' | head -1 | cut -d"," -f1)
    ips="$ips$ip\n"
done
echo -e "$ips"
