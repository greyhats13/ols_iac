## create vpc.tf variables
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

#vpc params
variable "vpc_description" {
  type        = string
  description = "The description of the VPC"
}

variable "ip_range" {
  type        = string
  description = "The IP range of the VPC"
}