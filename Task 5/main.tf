# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  profile = "terraform_user"
  region = "us-east-1"
}

## create variable for AMI, VPC ID and Subnet 

variable "subnet_pub" {
  description = "Public_Subnet_1"
  default = "subnet-08250cbd0e39253cb"
}
variable "ami_id" {
  description = "AMI ID"
  default = "ami-0d5eff06f840b45e9"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity-T2" {
  ami = "${var.ami_id}"
  subnet_id = "${var.subnet_pub}"
  instance_type = "t2.micro"
  count = 4
  tags = {
    Name = "Udacity T2"
  }
}
   
 # TODO: provision 2 m4.large EC2 instances named Udacity M4

resource "aws_instance" "Udacity-M4" {
  ami = "${var.ami_id}"
  subnet_id = "${var.subnet_pub}"
  instance_type = "m4.large"
  count = 2
  tags = {
    Name = "Udacity M4"
  }
}
