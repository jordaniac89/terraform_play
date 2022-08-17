terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

data "aws_region" "current"{}

provider "aws" {
    region                   = var.region
    shared_config_files      = [var.aws_config]
    shared_credentials_files = [var.aws_creds]
    profile                  = var.aws_profile    
}