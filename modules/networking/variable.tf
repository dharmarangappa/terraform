variable "env" {
   description = "Environment name(dev,stage,qa,prod)"
   tyep = string
}

variable "vpc_cidr" {
   description = "CIDR block for vpc"
   type = string
   defalut = "10.0.0.0/16"

variable "public_subnet_cidr" {
   description = "CIDR block for public subnet"
   type = string
   default = "10.0.0.1/24"
}

variable "aws_region" {
   description = "AWS region"
   type = string
   defalut = "ap-south-1"
}
