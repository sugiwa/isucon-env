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
  instance_type = "c5.large"
  ami           = "ami-01bef798938b7644d"
  # ami           = "ami-0eab443f6af50bcfe"
  az            = "ap-northeast-1a"
  tag_name      = "private-isu"

  vpc_id             = module.network.vpc_id
  instance_subnet_id = module.network.public_subnet_id

  setup_script = "./scripts/setup_app.sh"
}
