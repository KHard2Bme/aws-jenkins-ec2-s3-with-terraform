variable "aws_region" {
  description = "The AWS region to deploy resources"
  default = "us-east-1"
}


variable "instance_type" {
  description = "EC2 instance type for Jenkins"
  default = "t2.micro"
}


variable "ami_id" {
  description = "Amazon Linux 2023 AMI ID"
  default = "ami-00ca32bbc84273381"
}


variable "allowed_ssh_ip" {
  description = "Your public IP for SSH access"
  default = "0.0.0.0/0"
}