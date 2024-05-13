module "vpc" {
  source = "./vpc"
  my_cidr_block = var.naresh_cidr
  instance_tenancy = var.naresh_tenancy
  my_vpc_name = var.vpc_name

  
}

module "subnet" {
  source = "./subnet"
  Naresh_vpc_id = module.vpc.vpc_id
  my_cidr_block = var.subnet_cidr
  aws_subnet_name = var.name_subnet
}
