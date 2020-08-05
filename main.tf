provider "aws" {
  region = "eu-west-2"
}

module "vpc" {
  source = "./vpc"

}

module "sg" {
  source     = "./sg"
  aws_vpc_id = module.vpc.main_vpc
  //  aws_private_vpc_id = module.vpc.private_subnets
}

module "rds" {
  source    = "./rds"
  rds_sg_id = module.sg.rds_sg
  subnet_1  = module.vpc.private_subnets
  subnet_2  = module.vpc.private_subnets_2
}

module "asg" {
  source            = "./asg"
  aws_sg            = module.sg.webserver_sg
  aws_public_subnet = module.vpc.public_subnets
}

/*resource "aws_instance" "my_webserver" {
  ami           = "ami-00f6a0c18edb19300" #Ubuntu image
  instance_type = "t2.micro"

  vpc_security_group_ids = [module.sg.webserver_sg]
  subnet_id              = module.vpc.public_subnets
  // depends_on             = [module.vpc.public_subnets]
  tags = {
    Name    = "My_AWS_webs"
    owner   = "Yurii Bakhur"
    project = "Terraform Lesson2"
  }
} */
