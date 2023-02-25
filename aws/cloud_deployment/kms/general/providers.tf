provider "aws" {
  region  = "us-west-1"
  # profile = "${var.unit}-${var.env}"
  assume_role {
    role_arn = "arn:aws:iam::124456474132:role/iac"
  }
}