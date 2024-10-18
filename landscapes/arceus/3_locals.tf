locals {
  sos_project = module.secret_of_secrets.slug

  dns_clusters = {
    Opal  = "opal"
    Ruby  = "ruby"
    Mica  = "mica"
    Talc  = "talc"
    Topaz = "topaz"
    Amber = "amber"
  }
}
