#!/bin/bash

# Function to create a VPC
create_vpc() {
    echo "Creating VPC..."
    Region="us-east-2"
    vpc_id=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query 'Vpc.{VpcId:VpcId}' --output text)
    echo "VPC created with ID: $vpc_id"
}

# Function to create subnets
create_subnets() {
    echo "Creating subnets..."
    public_subnet_id=$(aws ec2 create-subnet --vpc-id "$vpc_id" --cidr-block 10.0.1.0/24 --availability-zone us-east-2a --query 'Subnet.{SubnetId:SubnetId}' --output text)
    private_subnet_id=$(aws ec2 create-subnet --vpc-id "$vpc_id" --cidr-block 10.0.2.0/24 --availability-zone us-east-2b --query 'Subnet.{SubnetId:SubnetId}' --output text)
    echo "Public subnet created with ID: $public_subnet_id"
    echo "Private subnet created with ID: $private_subnet_id"
}

# Function to create an Internet Gateway (IGW)
create_internet_gateway() {
    echo "Creating Internet Gateway..."
    igw_id=$(aws ec2 create-internet-gateway --query 'InternetGateway.{InternetGatewayId:InternetGatewayId}' --output text)
    aws ec2 attach-internet-gateway --internet-gateway-id "$igw_id" --vpc-id "$vpc_id"
    echo "Internet Gateway created with ID: $igw_id and attached to VPC: $vpc_id"
}

# Function to create route tables
create_route_tables() {
    echo "Creating route tables..."
    public_rt_id=$(aws ec2 create-route-table --vpc-id "$vpc_id" --query 'RouteTable.{RouteTableId:RouteTableId}' --output text)
    private_rt_id=$(aws ec2 create-route-table --vpc-id "$vpc_id" --query 'RouteTable.{RouteTableId:RouteTableId}' --output text)
    echo "Public route table created with ID: $public_rt_id"
    echo "Private route table created with ID: $private_rt_id"

    aws ec2 create-route --route-table-id "$public_rt_id" --destination-cidr-block 0.0.0.0/0 --gateway-id "$igw_id"
    aws ec2 associate-route-table --route-table-id "$public_rt_id" --subnet-id "$public_subnet_id"
    aws ec2 associate-route-table --route-table-id "$private_rt_id" --subnet-id "$private_subnet_id"
}

# Function to create a security group with inbound rules
create_security_group() {
    echo "Creating security group..."
    sg_id=$(aws ec2 create-security-group --group-name MySecurityGroup --description "My security group" --vpc-id "$vpc_id" --query 'GroupId' --output text)
    echo "Security group created with ID: $sg_id"

    aws ec2 authorize-security-group-ingress --group-id "$sg_id" --protocol tcp --port 22 --cidr 0.0.0.0/0
    aws ec2 authorize-security-group-ingress --group-id "$sg_id" --protocol tcp --port 80 --cidr 0.0.0.0/0
}

# Function to launch an EC2 instance in the public subnet with user data
launch_ec2_instance() {
user_data_base64=$(echo -n "#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd" | base64 -w0)

# Launch EC2 instance with user data
aws ec2 run-instances \
    --image-id ami-0efbb9b523fbc6c53 \
    --instance-type t2.micro \
    --key-name pspk \
    --subnet-id "$public_subnet_id" \ 
    --security-group-ids "$sg_id" \
    --associate-public-ip-address 
    --user-data "$user_data_base64" \
    --echo "EC2 instance launched with ID: $instance_id" 
}

# Main script
create_vpc
create_subnets
create_internet_gateway
create_route_tables
create_security_group
launch_ec2_instance

public_ip=$(aws ec2 describe-instances --instance-ids "$instance_id" --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

echo "Instance ID: $instance_id"
echo "Public IP: $public_ip"


