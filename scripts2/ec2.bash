#!/bin/bash
# AWS EC2 Instance Configuration
instance_type="t2.micro"
image_id="ami-069d73f3235b535bd" # Specify the desired AMI ID
key_name="pem"
security_group_id="sg-07c250a18cdfa1f3a"  # Specify the security group ID
subnet_id="subnet-0a7fa53614b5bb6ba"  # Specify the subnet ID
tag_name="bash"
# Provision EC2 instance
instance_id=$(aws ec2 run-instances \
  --image-id "$image_id" \
  --instance-type "$instance_type" \
  --key-name "$key_name" \
  --security-group-ids "$security_group_id" \
  --subnet-id "$subnet_id" \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$tag_name}]" \
  --query "Instances[0].InstanceId" \
  --output text)
# Check if instance creation was successful
if [ -n "$instance_id" ]; then
  echo "EC2 instance created with ID: $instance_id"
fi
