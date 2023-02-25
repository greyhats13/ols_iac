terraform {
  backend "s3" {
    bucket  = "ols-master-storage-s3-iac"
    region  = "us-west-1"
    key     = "s3/ols-master-storage-s3-iac.tfstate"
    profile = "ols-master"
  }
}

data "terraform_remote_state" "kms_general" {
  backend = "s3"
  config = {
    bucket = "ols-master-storage-s3-iac"
    key    = "kms/ols-master-security-kms-general.tfstate"
    region = "us-west-1"
  }
}

module "s3_bucket" {
  source            = "../../../modules/storage"
  region            = "us-west-1"
  unit              = "ols"
  env               = "master"
  code              = "storage"
  feature           = "s3"
  sub               = ["iac"]
  acl               = "private"
  kms_master_key_id = data.terraform_remote_state.kms_general.outputs.kms_general_key_arn
  sse_algorithm     = "aws:kms"
}
