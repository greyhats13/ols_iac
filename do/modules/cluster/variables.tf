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

#k8s
variable "do_token" {
  type        = string
  description = "DO token"
}
variable "version_prefix" {
  type        = string
  description = "k8s version prefix"
}

variable "node_type" {
  type        = string
  description = "k8s node type"
}

variable "auto_scale" {
  type        = bool
  description = "k8s autoscale"
}

variable "min_nodes" {
  type        = number
  description = "k8s min nodes"
}

variable "max_nodes" {
  type        = number
  description = "k8s max nodes"
}

variable "node_labels" {
  type        = map(any)
  description = "k8s node labels"
}

variable "node_taint" {
  type        = map(any)
  description = "k8s node taints"
}
