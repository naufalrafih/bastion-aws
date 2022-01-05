terraform {
  source = "../..//module"
}

inputs = {
  region            = "ap-southeast-1"
  private_key_path  = "/home/naufal/playground/terraform/bastion-host/terragrunt/prod/private_key.pem"
  environment       = "prod"
  vpc_cidr_block    = "192.171.0.0/16"
  subnet_cidr_block = "192.171.0.0/24"
  ami_id            = "ami-055d15d9cfddf7bd3"
  instance_type     = "t3.small"
  sg_port           = "22"
  sg_cidr_block     = "0.0.0.0/0"
}