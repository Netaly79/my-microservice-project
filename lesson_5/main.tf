terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

module "vpc" {
  source              = "./modules/vpc"           # Шлях до модуля VPC
  vpc_cidr_block      = "10.0.0.0/16"             # CIDR блок для VPC
  public_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]        # Публічні підмережі
  private_subnets     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]         # Приватні підмережі
  availability_zones  = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]            # Зони доступності
  vpc_name            = "vpc-nat"              # Ім'я VPC
}

# Підключаємо модуль ECR
module "ecr" {
  source           = "./modules/ecr"
  repository_name  = "lesson-5-ecr-nat"
}

module "eks" {
  source          = "./modules/eks"          
  cluster_name    = "eks-cluster-demo-nat"            # Назва кластера
  subnet_ids      = module.vpc.public_subnets     # ID підмереж
  instance_type   = "t3.medium"                    # Тип інстансів
  desired_size    = 2                             # Бажана кількість нодів
  max_size        = 2                             # Максимальна кількість нодів
  min_size        = 1                             # Мінімальна кількість нодів
}

data "aws_eks_cluster_auth" "eks" {
  name = var.cluster_name
}

provider "helm" {
  kubernetes = {
    host                   = module.eks.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.eks_cluster_ca_data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}

module "jenkins" {
  source            = "./modules/jenkins"
  cluster_name      = module.eks.eks_cluster_name
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.oidc_provider_url
  github_pat        = var.github_pat
  github_user       = var.github_user
  github_repo_url   = var.github_repo_url
  depends_on        = [module.eks]
  providers         = {
    helm       = helm
    kubernetes = kubernetes
  }
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "eks-cluster-demo-nat"
}

provider "kubernetes" {
  host                   = module.eks.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.eks_cluster_ca_data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

module "argo_cd" {
  source        = "./modules/argo_cd"
  namespace     = "argocd"
  chart_version = "5.46.4"
  depends_on    = [module.eks]
}

module "rds" {
  source = "./modules/rds"
  name                       = "myappnatdb"
  use_aurora                 = true
  aurora_instance_count      = 2

  # --- RDS-only ---
  engine                     = "postgres"
  engine_version             = "17.2"
  parameter_group_family_rds = "postgres17"
  db_name                    = "myappnatdb"

  # --- Aurora-only ---
  engine_cluster             = "aurora-postgresql"
  engine_version_cluster     = "15.3"
  parameter_group_family_aurora = "aurora-postgresql15"

  # Common
  instance_class             = "db.t3.medium"
  allocated_storage          = 20
  
  username                   = "postgres"
  password                   = "admin123AWS23"
  subnet_private_ids         = module.vpc.private_subnets
  subnet_public_ids          = module.vpc.public_subnets
  publicly_accessible        = true
  vpc_id                     = module.vpc.vpc_id
  multi_az                   = true
  backup_retention_period    = 7
  parameters = {
    max_connections              = "200"
    log_min_duration_statement   = "500"
  }

  tags = {
    Environment = "dev"
    Project     = "myapp-nat"
  }
} 
