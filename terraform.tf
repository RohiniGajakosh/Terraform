terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.27.0"
    }
  }
  backend "s3" {
    bucket = "my-gitsecure-bucket"
    key = "remotebackend/terraform.tfstate"
    dynamodb_table = "my-dynamodb-lock-table"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}
provider "random" {
  
}
