#create module vpc from .../../modules/vpc
module "vpc" {
  source = "../modules/network"
  unit = "ols"
  env = "dev"
  code = "network"
  feature = ["vpc"]
  region = "sgp1"
  vpc_description = "VPC for OLS Dev"
  ip_range = "10.0.0.0/16"
}
