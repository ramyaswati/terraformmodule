#configure your provider 
provider "aws" {
  region = var.region
  //profile = "terraform-user"
}

#create vpc
module "vpc" {
  source = "../Modules/vpc"
    region = var.region
    projectname = var.projectname
    vpc_cidr = var.vpc_cidr
    public_subnet_az1_cidr = var.public_subnet_az1_cidr
    public_subnet_az2_cidr = var.public_subnet_az2_cidr
    private_app_subnet_az1_cidr = var.private_app_subnet_az1_cidr
    private_app_subnet_az2_cidr = var.private_app_subnet_az2_cidr
    private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
    private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr

}

module "nat-gateway" {
    source = "../Modules/nat-gateway"
    public_subnet_az1_id=module.vpc.public_subnet_az1_id
    internet_gateway=module.vpc.internet_gateway
    public_subnet_az2_id=module.vpc.public_subnet_az2_id
    vpc_id=module.vpc.vpc_id
    private_app_subnet_az1_id=module.vpc.private_app_subnet_az1_id
    private_data_subnet_az1_id=module.vpc.private_data_subnet_az1_id
    private_app_subnet_az2_id=module.vpc.private_app_subnet_az2_id
    private_data_subnet_az2_id=module.vpc.private_data_subnet_az2_id
}

module "sg" {
  source = "../Modules/sg"
  vpc_id = module.vpc.vpc_id
  
}

module "name" {
  source                = "../Modules/alb"
  projectname           =module.vpc.projectname
  alb_security_group_id = module.sg.alb_security_group_id
  public_subnet_az1_id  =module.vpc.public_subnet_az1_id
  public_subnet_az2_id  =module.vpc.public_subnet_az2_id
  vpc_id                =module.vpc.vpc_id
  
}