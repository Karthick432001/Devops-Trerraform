#provider block aws
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
resource "aws_key_pair" "two-tier-key" {
  key_name   = "two-tier-key"
  public_key = file("~/.ssh/id_rsa.pub")  # Replace with the path to your public key file
}

module "vpc" {
  source         = "./module/vpc"
  vpc_cidr_block = "10.0.0.0/16"
}

module "subnet" {
  source              = "./module/subnet"
  route_table_id      = module.vpc.route_table_id
  vpc_id              = module.vpc.vpc_id
  public_cidr         = ["10.0.0.0/18", "10.0.64.0/18"]
  public_subnet_name  = "public-subnet"
  availability_zone   = ["us-east-1a", "us-east-1b"]
  private_cidr        = ["10.0.128.0/18", "10.0.192.0/18"]
  private_subnet_name = "private-subnet"
}

module "lb" {
  source           = "./module/lb"
  vpc_id           = module.vpc.vpc_id
  lb_sg_id         = module.sg.lb_sg_id
  public_subnet_id = module.subnet.public_subnet_id
  lb_name          = "public-lb"
  ec2_instance_id  = module.ec2.ec2_instance_id
}

module "rds" {
  source            = "./module/rds"
  db_instance_class = "db.t2.micro"
  db_name           = "mysqldevdb"
  username          = "root"
  password          = "rootroot"
}

module "sg" {
  source     = "./module/sg"
  vpc_id     = module.vpc.vpc_id
  lb_sg_name = "lb-prod-sg"
  db_sg_name = "sb-prod-sg"
}

module "ec2" {
  source           = "./module/ec2"
  sg_id            = module.sg.ec2_sg_id
  public_subnet_id = module.subnet.public_subnet_id
}


