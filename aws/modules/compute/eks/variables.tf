#Naming Standard
variable "unit" {
  type        = string
  description = "business unit code"
}

variable "env" {
  type        = string
  description = "stage environment where the service or cloud resource will be deployed"
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

variable "region" {
  type        = string
  description = "AWS region"
}

#EKS arguments

variable "k8s_version" {
  type        = string
  description = "Kubernetes version"
}

variable "endpoint_private_access" {
  type        = bool
  description = "Enable private access to the cluster's Kubernetes API server endpoint"
}

variable "endpoint_public_access" {
  type        = bool
  description = "Enable public access to the cluster's Kubernetes API server endpoint"
}

variable "public_access_cidrs" {
  type = list(string)
  description = "The CIDR blocks that are allowed access to your cluster's public Kubernetes API server endpoint"
}

variable "vpc_id" {
  type = string
  description = "The VPC to use for the cluster security group"
}

variable "subnet_ids" {
  type = list(string)
  description = "The subnets to use for the cluster"
}

variable "eks_cluster_ingress_rules_cidr_blocks" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "EKS Cluster Ingress Rules CIDR Blocks"
  default     = null
}

variable "eks_cluster_ingress_rules_security_groups" {
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    security_groups = list(string)
  }))
  description = "EKS Cluster Ingress Rules Security Groups"
  default     = null
}

variable "eks_cluster_egress_rules_cidr_blocks" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "EKS Cluster Egress Rules CIDR Blocks"
  default     = null
}

variable "eks_cluster_egress_rules_security_groups" {
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    security_groups = list(string)
  }))
  description = "EKS Cluster Egress Rules Security Groups"
  default     = null
}

variable "key_arn" {
  type = string
  description = "The Amazon Resource Name (ARN) of the customer master key (CMK) to use for encryption"
}