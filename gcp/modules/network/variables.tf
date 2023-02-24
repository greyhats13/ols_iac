#Naming Standard
variable "region" {
  type        = string
  description = "GCP region"
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
  type        = list(string)
  description = "the name of AWS services feature"
}

# vpc arguments
variable "subnetwork_ip_cidr_range" {
  type        = string
  description = "IP CIDR range for the subnetwork"
  default     = "10.0.0.0/16"
}