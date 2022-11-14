provider "aws" {
  region  = var.region
  profile = "terraform-user"
}

module "vpc" {
  source = "../modules/vpc"
  region = var.region
  cidr = var.cidr
  project_name = var.project_name
  team = var.team
  routetable_cidr = var.routetable_cidr
}

module "nat_gateway" {
  source = "../modules/nat-gateway"
  project_name = var.project_name
  public_subnet_az1_id = module.vpc.public_subnet_az1_id
  public_subnet_az2_id = module.vpc.public_subnet_az2_id
  internet_gateway = module.vpc.internet_gateway
  vpc_id = module.vpc.vpc_id
  routetable_cidr = var.routetable_cidr
  private_subnet_app_az1_id = module.vpc.private_subnet_app_az1_id
  private_subnet_app_az2_id = module.vpc.private_subnet_app_az2_id
  private_subnet_data_az1_id = module.vpc.private_subnet_data_az1_id
  private_subnet_data_az2_id = module.vpc.private_subnet_data_az2_id

}


module "sg" {
  source = "../modules/security_groups"
  vpc_id = module.vpc.vpc_id
  sg_ports_alb_ingress = var.sg_ports_alb_ingress
  sg_ports_ecs_ingress = var.sg_ports_ecs_ingress
  sg_ports_alb_egress = var.sg_ports_alb_egress
  sg_ports_ecs_egress = var.sg_ports_ecs_egress
}


