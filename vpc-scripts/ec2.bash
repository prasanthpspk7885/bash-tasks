#!/bin/bash

# Base64 encode the user data
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
    --user-data "$user_data_base64" \
    --query 'Instances[0].InstanceId' \
    --output text
