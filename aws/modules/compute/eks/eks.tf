data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "${var.unit}-${var.env}-storage-s3-iac"
    key    = "vpc/${var.unit}-${var.env}-network-vpc-main.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "kms_general" {
  backend = "s3"
  config = {
    bucket = "${var.unit}-${var.env}-storage-s3-iac"
    key    = "kms/${var.unit}-${var.env}-security-kms-general.tfstate"
    region = var.region
  }
}

resource "aws_iam_role" "eks_role" {
  name = "${var.unit}-${var.env}-${var.code}-${var.feature}-${var.sub[0]}-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_cluster_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_role.name
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
resource "aws_iam_role_policy_attachment" "eks_pods_sg_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_role.name
}

resource "aws_eks_cluster" "cluster" {
  name     = "${var.unit}-${var.env}-${var.code}-${var.feature}-${var.sub[0]}"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = data.terraform_remote_state.network.outputs.network_public_subnet_id
    endpoint_private_access = true
    endpoint_public_access = true
  }

  encryption_config {
    provider {
      key_arn = data.terraform_remote_state.kms_general.outputs.kms_general_key_arn
    }
    resources = ["secrets"]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_attachment,
    aws_iam_role_policy_attachment.eks_pods_sg_attachment,
  ]
}