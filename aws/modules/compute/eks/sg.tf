## Create cluster security group

resource "aws_security_group" "cluster" {
  name        = "${var.unit}-${var.env}-${var.code}-${var.feature}-${var.sub[0]}-sg"
  description = "Security group for EKS Cluster"
  vpc_id      = var.vpc_id

  ## Create foreach loop for ingress and egress rules
  dynamic "ingress" {
    for_each = var.eks_cluster_ingress_rules_cidr_blocks != null ? var.eks_cluster_ingress_rules_cidr_blocks : []
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "ingress" {
    for_each = var.eks_cluster_ingress_rules_security_groups != null ? var.eks_cluster_ingress_rules_security_groups : []
    content {
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      security_groups  = ingress.value.security_groups
    }
  }

  dynamic "egress" {
    for_each = var.eks_cluster_egress_rules_cidr_blocks != null ? var.eks_cluster_egress_rules_cidr_blocks : []
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.eks_cluster_egress_rules_security_groups != null ? var.eks_cluster_egress_rules_security_groups : []
    content {
      from_port        = egress.value.from_port
      to_port          = egress.value.to_port
      protocol         = egress.value.protocol
      security_groups  = egress.value.security_groups
    }
  }

  tags = {
    Name = "${var.unit}-${var.env}-${var.code}-${var.feature}-${var.sub[0]}-sg"
  }
}