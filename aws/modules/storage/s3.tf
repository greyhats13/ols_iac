resource "aws_s3_bucket" "s3" {
  bucket        = "${var.unit}-${var.env}-${var.code}-${var.feature}-${var.sub[0]}"
  force_destroy = true
  tags = {
    Name    = "${var.unit}-${var.env}-${var.code}-${var.feature}-${var.sub[0]}"
    Env     = var.env
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_s3_bucket_acl" "s3_acl" {
  bucket = aws_s3_bucket.s3.id
  acl    = var.acl
}

resource "aws_s3_bucket_public_access_block" "s3_public_access" {
  bucket = aws_s3_bucket.s3.id

  block_public_acls       = var.acl == "private" ? true : false
  block_public_policy     = var.acl == "private" ? true : false
  ignore_public_acls      = var.acl == "private" ? true : false
  restrict_public_buckets = var.acl == "private" ? true : false
}