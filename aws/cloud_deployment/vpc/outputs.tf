## create VPC output based on the module

output "network_vpc_id" {
  value = module.vpc.vpc_id
}

output "network_vpc_arn" {
  value = module.vpc.vpc_arn
}

output "network_vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "network_public_subnet_id" {
  value = module.vpc.public_id
}

output "network_public_subnet_arn" {
  value = module.vpc.public_arn
}

output "network_node_subnet_id" {
  value = module.vpc.node_id
}

output "network_node_subnet_arn" {
  value = module.vpc.node_arn
}

output "network_app_subnet_id" {
  value = module.vpc.app_id
}

output "network_app_subnet_arn" {
  value = module.vpc.app_arn
}

output "network_data_subnet_id" {
  value = module.vpc.data_id
}

output "network_data__subnet_arn" {
  value = module.vpc.data_arn
}

output "network_igw_id" {
  value = module.vpc.igw_id
}

output "network_igw_arn" {
  value = module.vpc.igw_arn
}

output "network_nat_id" {
  value = module.vpc.nat_id
}