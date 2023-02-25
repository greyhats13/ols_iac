#Naming Standard
variable "region" {
  type        = string
  description = "AWS region"
}

variable "unit" {
  type        = string
  description = "business unit code"
}

variable "env" {
  type        = string
  description = "stage environment where the infrastructure will be deployed"
}

variable "code" {
  type        = string
  description = "service domain code to use"
}

variable "feature" {
  type        = string
  description = "the name of AWS services feature"
}

variable "sub" {
  type        = list(string)
  description = "the name of AWS services subfeature"
}


#VPC Arguments
variable "vpc_cidr" {
  type        = string
  description = "Network VPC CIDR"
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS SUpport"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS Hostnames"
}

# #Elastic IP Arguments
variable "total_eip" {
  type        = number
  description = "Total elastic IP"
}
