# resource "aws_iam_role" "node_role" {
#   name = "${var.unit}-${var.env}-${var.code}-${var.feature}-${var.sub[1]}-role"

#   assume_role_policy = jsonencode({
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "ec2.amazonaws.com"
#       }
#     }]
#     Version = "2012-10-17"
#   })
# }

# resource "aws_iam_role_policy_attachment" "eks_node_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.node_role.name
# }

# resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.node_role.name
# }

# resource "aws_iam_role_policy_attachment" "eks_ecr_policy_readonly" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.node_role.name
# }

# # Create security group for EKS Node Group

# resource "aws_security_group" "eks_node_group" {
#   name        = "${var.unit}-${var.env}-${var.code}-${var.feature}-${var.sub[1]}-sg"
#   description = "Security group for EKS Node Group"
#   vpc_id      = data.terraform_remote_state.network.outputs.network_vpc_id

#   tags = {
#     Name = "${var.unit}-${var.env}-${var.code}-${var.feature}-${var.sub[1]}-sg"
#   }
# }

# resource "aws_eks_node_group" "ondemand" {
#   cluster_name    = aws_eks_cluster.cluster.name
#   node_group_name = "${var.unit}-${var.env}-${var.code}-${var.feature}-${var.sub[1]}"
#   node_role_arn   = aws_iam_role.node_role.arn
#   subnet_ids      = data.terraform_remote_state.network.outputs.network_app_subnet_id
#   scaling_config {
#     desired_size = 2
#     max_size     = 4
#     min_size     = 2
#   }

#   update_config {
#     max_unavailable = 2
#   }

#   # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#   # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#   depends_on = [
#     aws_iam_role_policy_attachment.eks_node_policy,
#     aws_iam_role_policy_attachment.eks_cni_policy,
#     aws_iam_role_policy_attachment.eks_ecr_policy_readonly,
#   ]

#   tags = {
#     "kubernetes.io/cluster/${aws_eks_cluster.cluster.name}" = "shared"
#   }

#   lifecycle {
#     ignore_changes = [scaling_config[0].desired_size]
#   }
# }