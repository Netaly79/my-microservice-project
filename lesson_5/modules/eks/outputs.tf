output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "eks_node_role_arn" {
  value = aws_iam_role.eks.arn
}