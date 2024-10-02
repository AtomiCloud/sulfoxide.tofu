output "location" {
  value = cloudflare_r2_bucket.main.location
}

output "id" {
  value = cloudflare_r2_bucket.main.id
}

output "name" {
  value = cloudflare_r2_bucket.main.name
}

output "key" {
  value = cloudflare_api_token.this.id
}

output "secret" {
  value = sha256(cloudflare_api_token.this.value)
  sensitive = true
}