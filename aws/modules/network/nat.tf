resource "aws_eip" "eip" {
  count = var.total_eip
  vpc   = true

  tags = {
    "Name"       = "${var.unit}-${var.env}-${var.code}-${var.feature}-${var.sub[2]}-${count.index}"
    "Unit"       = var.unit
    "Env"        = var.env
    "Code"       = var.code
    "Feature"    = var.feature
    "SubFeature" = var.sub[2]
  }
}

resource "aws_nat_gateway" "nat" {
  count         = length(aws_subnet.public)
  allocation_id = element(aws_eip.eip.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)

  tags = {
    "Name"       = "${var.unit}-${var.env}-${var.code}-${var.feature}-${var.sub[2]}-${element(data.aws_availability_zones.az.names, count.index)}"
    "Unit"       = var.unit
    "Env"        = var.env
    "Code"       = var.code
    "Feature"    = var.feature
    "SubFeature" = var.sub[2]
    "Zones"   = element(data.aws_availability_zones.az.names, count.index)
  }
}