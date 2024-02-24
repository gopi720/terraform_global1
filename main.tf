terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
}
provider "aws" {
  region = "ap-south-1"
  profile = "default"
}
module "vpc_module" {
  source = "../terraformmodule/modules/service/network/vpc"
  vpc_cidr = var.anitha_cdblock
}
module "subnet_module" {
  source = "../terraformmodule/modules/service/network/subnet"
  vpc_id = module.vpc_module.vpc_id
  subnetcidr_block = var.anitha_subnet
}
module "anitha_ec2_module" {
  source = "../terraformmodule/modules/service/compute/ec2"
  subnet_id = module.subnet_module.subnet_id
  instance_type = var.anitha_instance
  ami = var.anitha_ami
  key_pair = var.anitha_key
}