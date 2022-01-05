variable "region" {
  default = "ap-southeast-1"
}

variable "private_key_path" {
  default = "/home/naufal/playground/terraform/bastion-terraform/module/private_key.pem"
}

variable "environment" {
  default = "default"
}

variable "vpc_cidr_block" {
  default = "192.168.0.0/16"
}

variable "subnet_cidr_block" {
  default = "192.168.0.0/24"
}

variable "ami_id" {
  default = "ami-055d15d9cfddf7bd3"
}

variable "instance_type" {
  default = "t3.small"
}

variable "sg_port" {
  default = 22
}

variable "sg_cidr_block" {
  default = "0.0.0.0/0"
}