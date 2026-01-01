terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.27.0"
    }
  }
  backend "s3" {
    bucket = "my-gitsecure-bucket"
    key = "remotebackend/terraform.tfstate" #<-- this is the path to the state file in the S3 bucket
    region = "ap-south-1"
    encrypt = true # to encrypt the state file at rest
    use_lockfile = true # to provide state locking 
  }
}

provider "aws" {
  region = "ap-south-1"
}
provider "random" {
  
}
