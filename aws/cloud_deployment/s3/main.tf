module "s3_bucket" {
  source  = "../../../modules/storage"
  region  = "ap-southeast-1"
  unit    = "ols"
  env     = "prd"
  code    = "storage"
  feature = "s3"
  sub     = ["tfstate"]
}