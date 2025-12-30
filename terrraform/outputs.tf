output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.this.name
}

output "eks_cluster_endpoint" {
  description = "EKS API endpoint"
  value       = aws_eks_cluster.this.endpoint
}

output "eks_cluster_role_arn" {
  description = "IAM role ARN for EKS cluster"
  value       = aws_iam_role.eks_cluster_role.arn
}
