locals {
  name = "${var.landscape}-${var.cluster}"

  az = var.azs[var.single_az_index]

  basic_tags = merge({

    Landscape = var.landscape
    Cluster   = var.cluster

    Region    = var.region
    ManagedBy = "Terraform"

    Layer = "0"
  }, var.additional_tags)
}