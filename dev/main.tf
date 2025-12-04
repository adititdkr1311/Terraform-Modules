provider "aws" {
  region = "ap-south-1"
}

module "my_vpc" {
  source      = "../modules/vpc"
  vpc_cidr    = "192.168.0.0/16"
  tenancy     = "default"
  subnet_cidr = "192.168.1.0/24"
}

module "my_ec2" {
  source        = "../modules/ec2"
  ec2_count     = 1
  ami_id        = "ami-5a8da735"
  instance_type = "t2.micro"
  subnet_id     = "${module.my_vpc.subnet_id}"
}

# create s3 bucket aws

resource "aws_s3_bucket" "terraform-state-storage-s3" {
  bucket = "${var.bucket_name}"
  region = "ap-south-1"

  versioning {
    enabled = false
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    name = "S3 Remote Terraform State Store"
    proj = "networknuts"
    env = "${var.env}"
  }
}


# create a DynamoDB table for locking the state file

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "${var.table_name}"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    name = "DynamoDB Terraform State Lock Table"
    proj = "networknuts"
    env = "${var.env}"
  }
}

# store tfstate in s3 and locking information in DynamoDB

terraform {
  backend "s3" {
    encrypt = true
    bucket = "${var.bucket_name}"
    region = "ap-south-1"
    dynamodb_table = "${var.table_name}"
    key = "terraform-state/terraform.tfstate"
  }
}
