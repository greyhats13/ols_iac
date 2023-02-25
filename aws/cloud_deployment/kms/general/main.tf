terraform {
  backend "s3" {
    bucket  = "ols-master-storage-s3-iac"
    region  = "us-west-1"
    key     = "kms/ols-master-security-kms-general.tfstate"
    profile = "ols-master"
  }
}

data "local_file" "kms_policy" {
  filename = "${path.module}/kms_policy.json"
}

module "kms_general" {
  source                   = "../../../modules/security/kms"
  region                   = "us-west-1"
  unit                     = "ols"
  env                      = "master"
  code                     = "security"
  feature                  = "kms"
  sub                      = ["general"]
  description              = "General Customer Managed Key on master account"
  key_usage                = "ENCRYPT_DECRYPT"
  enable_key_rotation      = true
  deletion_window_in_days  = 7
  is_enabled               = true
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  policy                   = data.local_file.kms_policy.content
}