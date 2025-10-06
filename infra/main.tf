terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
  required_version = ">=1.5.0"
}

provider "aws" {
  region = "eu-central-1"
}

#Create ECR Repos
resource "aws_ecr_repository" "handler" {
  name = "handler-service"
}
resource "aws_ecr_repository" "processor" {
  name = "processor-service"
}
 