output "endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}

output "kubeconfig_certificate_authority_data" {
  value = aws_eks_cluster.cluster.certificate_authority[0].data
}