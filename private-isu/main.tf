terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-northeast-1"
}

module "network" {
  source = "./modules/network"

  az       = "ap-northeast-1a"
  tag_name = "private-isu"
}

module "app_instance" {
  source = "./modules/ec2"

  instance_name = "private-isu-app"
  ami           = "ami-09a81b370b76de6a2"
  instance_type = "t2.micro"
  az            = "ap-northeast-1a"
  tag_name      = "private-isu"

  vpc_id             = module.network.vpc_id
  instance_subnet_id = module.network.public_subnet_id
}
