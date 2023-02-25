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

# import kms arn from kms module output tfstate s3 bucket
data "terraform_remote_state" "kms_general" {
  backend = "s3"
  config = {
    bucket = "${var.unit}-${var.env}-storage-s3-iac"
    key    = "kms/${var.unit}-${var.env}-security-kms-general.tfstate"
    region = var.region
  }
}

# add acl to s3 bucket
resource "aws_s3_bucket_acl" "s3_acl" {
  bucket = aws_s3_bucket.s3.id
  acl    = var.acl
}


# add public access block
resource "aws_s3_bucket_public_access_block" "s3_public_access" {
  bucket = aws_s3_bucket.s3.id

  block_public_acls       = var.acl == "private" ? true : false
  block_public_policy     = var.acl == "private" ? true : false
  ignore_public_acls      = var.acl == "private" ? true : false
  restrict_public_buckets = var.acl == "private" ? true : false
}

# add server side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_serverside_encryption" {
  bucket = aws_s3_bucket.s3.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = data.terraform_remote_state.kms_general.outputs.kms_general_key_arn
      sse_algorithm     = "aws:kms"
    }
  }
}