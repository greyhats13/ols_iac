resource "aws_kms_key" "kms" {
  description              = var.description
  key_usage                = var.key_usage
  deletion_window_in_days  = var.deletion_window_in_days
  is_enabled               = var.is_enabled
  enable_key_rotation      = var.enable_key_rotation
  customer_master_key_spec = var.customer_master_key_spec
  policy                   = var.policy
  tags = {
    "Name"       = "${var.unit}-${var.env}-${var.code}-${var.feature}-${var.sub[0]}"
    "Unit"       = var.unit
    "Env"        = var.env
    "Code"       = var.code
    "Feature"    = var.feature
    "SubFeature" = var.sub[0]
  }
}

resource "aws_kms_alias" "kms_alias" {
  name          = "alias/${var.unit}-${var.env}-${var.code}-${var.feature}-${var.sub[0]}"
  target_key_id = aws_kms_key.kms.key_id
}
