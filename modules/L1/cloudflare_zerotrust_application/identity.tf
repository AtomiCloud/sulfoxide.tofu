data "cloudflare_access_identity_provider" "auth0_saml" {
  name       = "Auth0 SAML"
  account_id = var.cloudflare_account_id
}

locals {

  idp = {
    saml = data.cloudflare_access_identity_provider.auth0_saml.id
  }

}