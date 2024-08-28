variable "infisical_client_id" {
  description = "Root Infisical Client ID"
  type        = string
  sensitive   = true
}

variable "infisical_client_secret" {
  description = "Root Infisical Client Secret"
  type        = string
  sensitive   = true
}

variable "tofu_backend" {
  description = "Tofu Backend"
  type        = string
  sensitive   = true
}