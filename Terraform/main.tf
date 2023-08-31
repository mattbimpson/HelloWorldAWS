terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 5.0.0"
      }
    }
}

provider "aws" {
    region = "eu-west-2"
}

module "apigateway" {
  source = "./ApiGateway"
}
