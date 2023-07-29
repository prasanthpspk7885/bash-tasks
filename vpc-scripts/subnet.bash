#!/bin/bash
# Variables
VPC_ID="vpc-0ceb9caddc2c025eb"
PUBLIC_SUBNET_CIDR="192.168.0.0/28"
PRIVATE_SUBNET_CIDR="192.168.0.17/28"
AVAILABILITY_ZONE="us-east-2a"
# Create public subnet
PUBLIC_SUBNET_ID=$(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block $PUBLIC_SUBNET_CIDR --availability-zone $AVAILABILITY_ZONE --query 'Subnet.SubnetId' --output text)
# Create private subnet
PRIVATE_SUBNET_ID=$(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block $PRIVATE_SUBNET_CIDR --availability-zone $AVAILABILITY_ZONE --query 'Subnet.SubnetId' --output text)
# Print subnet IDs
echo "Public Subnet ID: $PUBLIC_SUBNET_ID"
echo "Private Subnet ID: $PRIVATE_SUBNET_ID"i
