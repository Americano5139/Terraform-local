module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.3"

  cluster_name    = var.cluster_name
  cluster_version = "1.30"
  subnet_ids      = var.subnet_ids
  vpc_id          = var.vpc_id

  create_kms_key = false

  # 이미 있는 alias/eks/eks-cluster 사용
  cluster_encryption_config = {
    resources        = ["secrets"]
    provider_key_arn = "arn:aws:kms:ap-northeast-2:126961545558:alias/eks/eks-cluster"
  }

  eks_managed_node_groups = {
    default = {
      desired_size    = 2
      max_size        = 3
      min_size        = 1
      instance_types  = ["t3.medium"]
      capacity_type   = "ON_DEMAND"
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

