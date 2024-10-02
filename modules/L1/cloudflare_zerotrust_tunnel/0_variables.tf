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
  description = "Cloudflare Gateway posture rule ID"
  type        = string
}

variable "ingress_fallback" {
  description = "Ingress Fallback service"
  type        = string
  default     = "http://localhost:8080"
}

variable "tunnel_ingress_rules" {
  description = <<EOF
  list of ingress rules config for tunnel.
  `name`: Name of the Application for the tunnel
  `dns`: DNS prefix for the tunnel
  `session`: Session. Should use "24h" by default
  `app_launcher_visible`: Should it show up in the dashboard
  `logo_url`: URL of the Logo
  `idp`: List of accepted IDPs. Accepted values: `saml`

  `path`: Ingress Path to match
  `service`: Target Kubernetes Service

  `warp`: Require WARP client
  `email_domains`: List of accepted email domains
  `saml_groups`: List of accepted SAML groups
  `countries`: List of accepted countries

  `bypass_everyone`: Bypass Okta Authentication
  `bypass_ips`: Bypass Okta Authentication
EOF

  type = list(object({
    name                 = string
    dns                  = string
    session              = string
    app_launcher_visible = bool
    logo_url             = string
    idp                  = list(string)

    path    = string
    service = string

    warp          = bool
    email_domains = list(string)
    saml_groups   = list(string)
    countries     = list(string)

    bypass_everyone = bool
    bypass_ips      = list(string)

  }))
}
