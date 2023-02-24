terraform {
  backend "s3" {
    bucket  = "ols-master-storage-s3-iac"
    region  = "us-west-1"
    key     = "vpc/ols-master-network-vpc-main.tfstate"
    profile = "ols-master"
  }
}

module "vpc" {
  source               = "../../modules/network"
  region               = "us-west-1"
  unit                 = "ols"
  env                  = "master"
  code                 = "network"
  feature              = "vpc"
  sub                  = ["main", "subnet", "nat", "igw", "rt"]
  vpc_cidr             = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  total_eip            = 2
}