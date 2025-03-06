terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "terraform-state-sanjana"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc_ec2" {
  source            = "github.com/SanjanaKrishna/vpc-ec2-module.git"
  environment       = var.environment
  vpc_cidr          = var.vpc_cidr
  subnet_cidr       = var.subnet_cidr
  availability_zone = var.availability_zone
  ami_id            = var.ami_id
  instance_type     = var.instance_type
}
