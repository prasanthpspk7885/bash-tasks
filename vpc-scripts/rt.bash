#!/bin/bash
# Replace these variables with your AWS region, VPC ID, IGW ID, and NAT Gateway ID (if applicable)
aws_region="us-east-2"
vpc_id="vpc-0ceb9caddc2c025eb"
igw_id="igw-0ec692a5106e69480"
# Create the Public Route Table
public_rt_id=$(aws ec2 create-route-table --vpc-id $vpc_id --region $aws_region --query 'RouteTable.RouteTableId' --output text)
aws ec2 create-route --route-table-id $public_rt_id --destination-cidr-block 0.0.0.0/0 --gateway-id $igw_id --region $aws_region
aws ec2 create-tags --resources $public_rt_id --tags Key=Name,Value="Public-RT" --region $aws_region
echo "Public Route Table created with ID: $public_rt_id"
# Create the Private Route Table
private_rt_id=$(aws ec2 create-route-table --vpc-id $vpc_id --region $aws_region --query 'RouteTable.RouteTableId' --output text)
# Optionally, add specific routes to your private route table if you have a NAT Gateway
# aws ec2 create-route --route-table-id $private_rt_id --destination-cidr-block 0.0.0.0/0 --nat-gateway-id $nat_gateway_id --region $aws_region
aws ec2 create-tags --resources $private_rt_id --tags Key=Name,Value="Private-RT" --region $aws_region
echo "Private Route Table created with ID: $private_rt_id"
