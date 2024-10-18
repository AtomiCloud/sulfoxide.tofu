provider "infisical" {
  host          = "https://secrets.atomi.cloud"
  client_id     = var.infisical_client_id
  client_secret = var.infisical_client_secret
}

provider "cloudflare" {
  api_token = data.infisical_secrets.sulfoxide_tofu.secrets["CLOUDFLARE_API_TOKEN"].value
}