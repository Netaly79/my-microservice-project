# Required
variable "repository_name" {
  type        = string
  description = "Назва ECR репозиторію (унікальна в акаунті та регіоні)."
}

# Optional
variable "scan_on_push" {
  type        = bool
  description = "Чи сканувати образи на вразливості одразу після push."
  default     = true
}

variable "image_tag_mutability" {
  type        = string
  description = "IMMUTABLE заблокує зміну існуючих тегів; MUTABLE дозволяє перезапис."
  default     = "MUTABLE"
}

variable "force_delete" {
  type        = bool
  description = "Якщо true, видалення репо автоматично видаляє всі образи всередині."
  default     = true
}

variable "repository_policy" {
  type        = string
  description = "JSON-політика репозиторію."
  default     = null
}
