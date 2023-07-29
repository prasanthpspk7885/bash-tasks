#!/bin/bash
# Replace these variables with your desired values
GROUP_NAME="default-2"
VPC_ID="vpc-0ceb9caddc2c025eb"
REGION="us-east-2"  # Replace with your desired region
# Create the security group
echo "Creating Security Group..."
group_id=$(aws ec2 create-security-group --group-name $GROUP_NAME --description "My security group" --vpc-id $VPC_ID --query 'GroupId' --output text --region $REGION)
# Add inbound rules for ports 22 and 80
echo "Adding Inbound Rules..."
aws ec2 authorize-security-group-ingress --group-id $group_id --protocol tcp --port 22 --cidr 0.0.0.0/0 --region $REGION
aws ec2 authorize-security-group-ingress --group-id $group_id --protocol tcp --port 80 --cidr 0.0.0.0/0 --region $REGION
echo "Security Group created successfully."
echo "Security Group ID: $group_id"
