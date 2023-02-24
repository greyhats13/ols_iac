module "vpc" {
  source               = "../../modules/network"
  region               = "us-west-1"
  unit                 = "ols"
  env                  = "master"
  code                 = "network"
  feature              = "vpc"
  sub                  = ["main", "subnet", "nat-gw", "igw", "rt"]
  vpc_cidr             = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}