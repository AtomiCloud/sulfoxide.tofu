// service tree
variable "landscape" {
  description = "Landscape of the controller"
  type        = string
}

variable "cluster" {
  description = "Cluster Name"
  type        = string
}

# cloudflare
variable "cloudflare_account_id" {
  description = "Cloudflare account id"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone" {
  description = "Cloudflare Zone Domain Name"
  type        = string
}

variable "cloudflare_gateway_posture_rule_id" {
  description = "Cloudflare Require WARP posture rule ID"
  type        = string
}

# app configuration
variable "hostname" {
  description = "Hostname of the application"
  type        = string
}

variable "name" {
  description = "Name of the application"
  type        = string
}

variable "session" {
  description = "Session. Should use \"24h\" by default"
  type        = string
}

variable "app_launcher_visible" {
  description = "Should it show up in the dashboard"
  type        = bool
}

variable "logo_url" {
  description = "URL of the Logo"
  type        = string
}

variable "idp" {
  description = "List of accepted IDPs. Accepted values: `saml`"
  type        = list(string)
}

# policies
variable "warp" {
  description = "Require WARP client"
  type        = bool
}

variable "email_domains" {
  description = "List of email domains accepted for the login user"
  type        = list(string)
}

variable "saml_groups" {
  description = "List of groups accepted for the login user"
  type        = list(string)
}

variable "countries" {
  description = "List of countries accepted for the login user"
  type        = list(string)
}


variable "bypass_everyone" {
  description = "Bypass Authentication for everyone"
  type        = bool
}

variable "bypass_ips" {
  description = "Bypass authentication for these IPs"
  type        = list(string)
  default     = []
}

