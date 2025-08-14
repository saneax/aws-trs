# main.tf

# ===================================================================
# Configure the AWS Provider
# ===================================================================
# This block tells Terraform you'll be working with AWS.
# The provider will automatically look for credentials set as
# environment variables (AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY).
# You just need to specify the region where you want to create resources.
# ===================================================================
provider "aws" {
  region = "us-east-1" # You can change this to your preferred region
}

# ===================================================================
# Find the latest Amazon Linux 2 AMI
# ===================================================================
# This is a best practice. Instead of hardcoding an AMI ID, which
# can become outdated, this data source dynamically finds the most
# recent Amazon Linux 2 AMI in the specified region.
# ===================================================================
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# ===================================================================
# Define the EC2 Instance Resource
# ===================================================================
# This block defines the virtual server you want to create.
# We give it a logical name "my_test_instance" for Terraform to track.
# ===================================================================
resource "aws_instance" "my_test_instance" {
  # Use the dynamic AMI ID found by the data source above
  ami           = data.aws_ami.latest_amazon_linux.id

  # t2.micro is eligible for the AWS Free Tier
  instance_type = "t2.micro"

  # Tags are key-value pairs that help you manage and identify your resources.
  tags = {
    Name        = "Terraform-Test-Instance"
    Project     = "Learning-Terraform"
    ManagedBy   = "Terraform"
  }
}

# ===================================================================
# Output the Public IP Address
# ===================================================================
# This block tells Terraform to print the public IP address of the
# instance after it has been created. This is useful for connecting to it.
# ===================================================================
output "instance_public_ip" {
  description = "Public IP address of the EC2 instance."
  value       = aws_instance.my_test_instance.public_ip
}
