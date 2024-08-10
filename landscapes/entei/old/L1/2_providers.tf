provider "cloudflare" {

  alias = "main"

  api_token = data.doppler_secrets.arceus_sulfoxide_terraform.map.MANUAL_CLOUDFLARE_TOKEN
}

provider "neon" {

  alias   = "main"
  api_key = data.doppler_secrets.arceus_sulfoxide_terraform.map.MANUAL_NEON_TOKEN

}