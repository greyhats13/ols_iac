resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    "Name"       = "${var.unit}-${var.env}-${var.code}-${var.feature}-${var.sub[0]}"
    "Unit"       = var.unit
    "Env"        = var.env
    "Code"       = var.code
    "Feature"    = var.feature
    "SubFeature" = var.sub[0]
  }
}
