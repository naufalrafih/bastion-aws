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
}