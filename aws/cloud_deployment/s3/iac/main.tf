terraform {
  backend "s3" {
    bucket  = "ols-master-storage-s3-iac"
    region  = "us-west-1"
    key     = "s3/ols-master-storage-s3-iac.tfstate"
    profile = "ols-master"
  }
}

module "s3_bucket" {
  source  = "../../../modules/storage"
  region  = "us-west-1"
  unit    = "ols"
  env     = "master"
  code    = "storage"
  feature = "s3"
  sub     = ["iac"]
  acl     = "private"
}