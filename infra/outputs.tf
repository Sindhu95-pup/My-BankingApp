#Output the repo URIs
output "handler_repo_url" {
  value = aws_ecr_repository.handler.repository_url
}
output "processor_repo_url" {
  value = aws_ecr_repository.processor.repository_url
}
output "vpc_id" {
  value = module.vpc.vpc_id
}
output "public_subnets" {
  value = module.vpc.public_subnets
}
output "private_subnets" {
  value = module.vpc.private_subnets
}
# EKS
output "eks_cluster_name" {
  value = aws_eks_cluster.this.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "eks_cluster_certificate_authority" {
  value = aws_eks_cluster.this.certificate_authority[0].data
}

# Fargate
output "fargate_profile_name" {
  value = aws_eks_fargate_profile.this.fargate_profile_name
}