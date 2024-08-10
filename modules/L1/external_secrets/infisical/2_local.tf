locals {

  labels = merge({
    "atomi.cloud/landscape" = var.landscape
    "atomi.cloud/platform"  = var.platform
    "atomi.cloud/service"   = var.service
    "atomi.cloud/layer"     = "1"
  }, var.additional_labels)

  annotations = merge({
    "atomi.cloud/landscape" = var.landscape
    "atomi.cloud/platform"  = var.platform
    "atomi.cloud/service"   = var.service
    "atomi.cloud/layer"     = "1"
  }, var.additional_labels)

  tags = merge({
    "atomi.cloud/landscape" = var.landscape
    "atomi.cloud/platform"  = var.platform
    "atomi.cloud/service"   = var.service
    "atomi.cloud/layer"     = "1"
  }, var.additional_labels)

  namespace = var.platform

  secret_name = "${var.platform}-${var.service}-secret-operator-infisical"
  client_id_key  = "CLIENT_ID"
  client_secret_key = "CLIENT_SECRET"


  lps      = "${var.landscape}-${var.platform}-${var.service}"
  lps-fqdn = "${var.landscape}.${var.platform}.${var.service}"

}