variable "aws_region" {
  type        = string
  description = "The AWS region where resources will be created."
  default     = "us-west-2"
}

variable "instance_type" {
  type        = string
  description = "The type of EC2 instance to create."
  default     = "t2.micro"
}

variable "ami_id" {
  type        = string
  description = "The AMI ID to use for the EC2 instance."
}

variable "instance_name" {
  type        = string
  description = "The name tag for the EC2 instance."
  default     = "Terraform_Demo"
}

