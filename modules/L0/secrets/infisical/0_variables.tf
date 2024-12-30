// service tree
variable "sos_project" {
  description = "Secret of secret project to store the secrets"
  type        = string
}

variable "store_service_token" {
  type        = bool
  description = "Store service token to sos_project"
}

variable "landscapes" {
  description = "Landscapes"
  type        = map(string)
}

variable "platform" {
  description = "Platform name"
  type        = string
}

variable "service" {
  description = "Service name"
  type        = string
}

variable "description" {
  description = "Service description"
  type        = string
}

variable "infisical_org_id" {
  description = "Infisical Org ID"
  type        = string
}