#VPC
output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "vpc_arn" {
    value = aws_vpc.vpc.arn
}

output "vpc_cidr_block" {
    value = aws_vpc.vpc.cidr_block
}

#Subnet
output "public_id" {
    value = aws_subnet.public.*.id
}

output "public_arn" {
    value = aws_subnet.public.*.arn
}

output "node_id" {
    value = aws_subnet.node.*.id
}

output "node_arn" {
    value = aws_subnet.node.*.arn
}

output "app_id" {
    value = aws_subnet.app.*.id
}

output "app_arn" {
    value = aws_subnet.app.*.arn
}

output "data_id" {
    value = aws_subnet.data.*.id
}

output "data_arn" {
    value = aws_subnet.data.*.arn
}

output "igw_id" {
    value = aws_internet_gateway.igw.id
}

output "igw_arn" {
    value = aws_internet_gateway.igw.arn
}

output "nat_id" {
    value = aws_nat_gateway.nat.*.id
}

output "public_rt_id" {
    value = aws_route_table.public_rt.id
}

output "public_rt_arn" {
    value = aws_route_table.public_rt.arn
}

output "app_rt_id" {
    value = aws_route_table.app_rt.*.id
}

output "app_rt_arn" {
    value = aws_route_table.app_rt.*.arn
}

output "data_rt_id" {
    value = aws_route_table.data_rt.*.id
}
