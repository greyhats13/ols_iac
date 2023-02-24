resource "aws_s3_bucket" "s3" {
  bucket        = "${var.unit}-${var.env}-${var.code}-${var.feature}-${var.sub[0]}"
  acl           = "private"
  force_destroy = true
  tags = {
    Name    = "${var.unit}-${var.env}-${var.code}-${var.feature}-${var.sub[0]}"
    Env     = var.env
  }
  lifecycle {
    create_before_destroy = true
  }
}