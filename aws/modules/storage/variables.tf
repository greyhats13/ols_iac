# Naming Standard
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

#S3 Arguments
variable "acl" {
  type        = string
  description = "The canned ACL to apply. Defaults to private"
}

variable "kms_master_key_id" {
  type        = string
  description = "The ID of the AWS KMS master key that AWS KMS uses to encrypt objects put in the bucket"
}

variable "sse_algorithm" {
  type        = string
  description = "The server-side encryption algorithm to use. Valid values are AES256 and aws:kms"
}