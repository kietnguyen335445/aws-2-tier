module "vpc" {
  source = "./Modules/vpc"
  vpc_cidr = var.vpc_cidr
  name = var.name
  public_subnet_1a_cidr = var.public_subnet_1a_cidr
  public_subnet_2b_cidr = var.public_subnet_2b_cidr
  private_subnet_3a_cidr = var.private_subnet_3a_cidr
  private_subnet_4b_cidr = var.private_subnet_4b_cidr
  private_subnet_5a_cidr = var.private_subnet_5a_cidr
  private_subnet_6b_cidr = var.private_subnet_6b_cidr
  region = var.region
}
module "natgw" {
  source = "./Modules/natgw"
  vpc_id = module.vpc.vpc_id
  igw_id = module.vpc.igw_id
  public_subnet_1a_id = module.vpc.public_subnet_1a_id
  public_subnet_2b_id = module.vpc.public_subnet_2b_id
  private_subnet_3a_id = module.vpc.private_subnet_3a_id
  private_subnet_4b_id = module.vpc.private_subnet_4b_id
  private_subnet_5a_id = module.vpc.private_subnet_5a_id
  private_subnet_6b_id = module.vpc.private_subnet_6b_id
}
module "sg" {
  source = "./Modules/sg"
  vpc_id = module.vpc.vpc_id
}
module "alb" {
  source = "./Modules/alb"
  name = module.vpc.name
  vpc_id = module.vpc.vpc_id
  alb_sg_id = module.sg.alb_sg_id
  public_subnet_1a_id = module.vpc.public_subnet_1a_id
  public_subnet_2b_id = module.vpc.public_subnet_2b_id
}
module "asg" {
  source = "./Modules/asg"
  name = module.vpc.name
  client_sg_id = module.sg.client_sg_id
  private_subnet_3a_id = module.vpc.private_subnet_3a_id
  private_subnet_4b_id = module.vpc.private_subnet_4b_id
  tg_arn = module.alb.tg_arn
}
module "rds" {
  source = "./Modules/rds"
  db_sg_id = module.sg.db_sg_id
  private_subnet_5a_id = module.vpc.private_subnet_5a_id
  private_subnet_6b_id = module.vpc.private_subnet_6b_id
  db_username = var.db_username
  db_password = var.db_password
}