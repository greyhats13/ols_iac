resource "digitalocean_vpc" "vpc" {
  name        = "${var.unit}-${var.env}-${var.code}-${var.feature[0]}-${var.region}"
  region      = var.region
  description = var.vpc_description
  ip_range    = var.ip_range
}