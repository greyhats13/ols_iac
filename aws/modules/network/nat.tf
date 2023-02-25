resource "aws_eip" "eip" {
  count = var.env != "master" && var.env != "dev" ? var.total_eip : 1
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
  count         = var.env != "master" && var.env != "dev" ? length(aws_subnet.public) : 1
  allocation_id = var.env != "master" && var.env != "dev" ? element(aws_eip.eip.*.id, count.index) : aws_eip.eip.0.id
  subnet_id     = var.env != "master" && var.env != "dev" ? element(aws_subnet.public.*.id, count.index) : aws_subnet.public.0.id

  tags = {
    "Name"       = "${var.unit}-${var.env}-${var.code}-${var.feature}-${var.sub[2]}-${element(data.aws_availability_zones.az.names, count.index)}"
    "Unit"       = var.unit
    "Env"        = var.env
    "Code"       = var.code
    "Feature"    = var.feature
    "SubFeature" = var.sub[2]
    "Zones"      = element(data.aws_availability_zones.az.names, count.index)
  }
}
