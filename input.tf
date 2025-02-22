variable "aws_region" {
  description = "The AWS region to deploy the instance"
  type        = string
  default     = "us-west-2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-830c94e3"
}

variable "instance_name" {
  description = "Tag for the EC2 instance"
  type        = string
  default     = "Terraform_Demo"
}

