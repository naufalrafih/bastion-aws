module "bastion" {
  source            = "./resource"
  region            = var.region
  private_key_path  = var.private_key_path
  environment       = var.environment
  vpc_cidr_block    = var.vpc_cidr_block
  subnet_cidr_block = var.subnet_cidr_block
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  sg_port           = var.sg_port
  sg_cidr_block     = var.sg_cidr_block

  //   source            = "./resource"
  //   region            = "ap-southeast-1"
  //   private_key_path  = "/home/naufal/playground/terraform/bastion-host/module/private_key.pem"
  //   environment       = "default"
  //   vpc_cidr_block    = "192.168.0.0/16"
  //   subnet_cidr_block = "192.168.0.0/24"
  //   ami_id            = "ami-055d15d9cfddf7bd3"
  //   instance_type     = "t3.small"
  //   sg_port           = "22"
  //   sg_cidr_block     = "0.0.0.0/0"
}

# ssh -i private_key.pem ubuntu@IP