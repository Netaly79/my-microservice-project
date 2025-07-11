output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "eks_node_role_arn" {
  value = aws_iam_role.eks.arn
}

output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.oidc.arn
}

output "oidc_provider_url" {
  value = aws_iam_openid_connect_provider.oidc.url
}

output "eks_cluster_ca_data" {
  value = aws_eks_cluster.eks.certificate_authority[0].data
}