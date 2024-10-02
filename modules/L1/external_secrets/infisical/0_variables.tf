variable "additional_labels" {
  type    = map(string)
  default = {}
}

# service tree
variable "landscape" {
  description = "Name of the landscape"
  type        = string
}

variable "platform" {
  description = "Name of the platform"
  type        = string
}

variable "service" {
  description = "Name of the service"
  type        = string
}


# secret propagation
variable "root_client_id" {
  description = "Root secret (client ID) for infisical, for secret of secrets vault"
  type        = string
  sensitive   = true
}

variable "root_client_secret" {
  description = "Root secret (client Secret) for infisical, for secret of secrets vault"
  type        = string
  sensitive   = true
}

# infisical configuration
variable "sos_project" {
  description = "Name of the project in the secret of secrets"
  type        = string
}

variable "path" {
  description = "Folder path for secret of secret of secrets project"
  type        = string
  default     = "/"
}

variable "infisical_api" {
  description = "URL of the infisical api"
  type        = string
  default     = "https://secrets.atomi.cloud"
}

variable "bump" {
  description = "Bump the module"
  type        = number
  default     = 0
}