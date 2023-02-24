resource "aws_internet_gateway" "igw" {
  vpc_id   = aws_vpc.vpc.id

  tags = {
    "Name" = "${var.unit}-${var.env}-${var.code}-${var.feature}-${var.sub[3]}"
    "Unit"    = var.unit
    "Env"     = var.env
    "Code"    = var.code
    "Feature" = var.feature
    "SubFeature" = var.sub[3]
  }
}