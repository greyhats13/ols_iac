terraform {
  backend "s3" {
    bucket   = "ols-master-storage-s3-iac"
    region   = "us-west-1"
    key      = "eks/ols-master-compute-eks-main.tfstate"
    role_arn = "arn:aws:iam::124456474132:role/iac"
    profile  = "ols-master"
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "ols-master-storage-s3-iac"
    key    = "vpc/ols-master-network-vpc-main.tfstate"
    region = "us-west-1"
  }
}

data "terraform_remote_state" "kms_general" {
  backend = "s3"
  config = {
    bucket = "ols-master-storage-s3-iac"
    key    = "kms/ols-master-security-kms-general.tfstate"
    region = "us-west-1"
  }
}

module "eks" {
  source                  = "../../../modules/compute/eks"
  region                  = "us-west-1"
  unit                    = "ols"
  env                     = "master"
  code                    = "compute"
  feature                 = "eks"
  sub                     = ["main", "ng"]
  k8s_version             = "1.25"
  vpc_id                  = data.terraform_remote_state.network.outputs.network_vpc_id
  subnet_ids              = data.terraform_remote_state.network.outputs.network_public_subnet_id
  endpoint_private_access = true
  endpoint_public_access  = true
  public_access_cidrs     = ["0.0.0.0/0"]
  eks_cluster_ingress_rules_cidr_blocks = [
    # Allow access to the cluster's Kubernetes API server endpoint from the VPC CIDR block
    {
      from_port   = 6443
      to_port     = 6443
      protocol    = "tcp"
      cidr_blocks = [data.terraform_remote_state.network.outputs.network_vpc_cidr_block]
    },
    # Allow incoming traffic from the worker node security group on port 10250 (Kubelet)
    {
      from_port   = 10250
      to_port     = 10250
      protocol    = "tcp"
      cidr_blocks = [data.terraform_remote_state.network.outputs.network_vpc_cidr_block]
    },
    # Allow incoming traffic from the worker node security group on port 10255 (Read-only Kubelet)
    {
      from_port   = 10255
      to_port     = 10255
      protocol    = "tcp"
      cidr_blocks = [data.terraform_remote_state.network.outputs.network_vpc_cidr_block]
    },
  ]
  eks_cluster_egress_rules_cidr_blocks = [
    # Allow outgoing traffic to the internet
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [data.terraform_remote_state.network.outputs.network_vpc_cidr_block]
    },
  ]
  key_arn = data.terraform_remote_state.kms_general.outputs.kms_general_key_arn
}
