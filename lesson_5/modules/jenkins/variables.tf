variable "kubeconfig" {
  description = "Шлях до kubeconfig файлу"
  type        = string
}

variable "cluster_name" {
  description = "Назва Kubernetes кластера"
  type        = string
}

variable "oidc_provider_arn" {
  description = "The ARN of the OIDC provider for EKS"
  type        = string
}

variable "oidc_provider_url" {
  description = "The URL of the OIDC provider for EKS"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace for deploying Jenkins"
  type        = string
  default     = "jenkins"
}