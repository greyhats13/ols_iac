terraform {
  backend "s3" {
    bucket  = "ols-master-storage-s3-iac"
    region  = "us-west-1"
    key     = "eks/ols-master-compute-eks-main.tfstate"
    profile = "ols-master"
  }
}

module "eks" {
  source                           = "../../../modules/compute/eks"
  region                           = "us-west-1"
  unit                             = "ols"
  env                              = "master"
  code                             = "compute"
  feature                          = "eks"
  sub                              = ["main", "ng"]
}