resource "aws_eip" "nat" {
  count = var.ips
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5"

  name = local.name
  cidr = var.cidr

  azs             = var.azs
  private_subnets = [for k, v in var.azs : cidrsubnet(var.cidr, 4, k)]
  public_subnets  = [for k, v in var.azs : cidrsubnet(var.cidr, 8, k + 48)]
  intra_subnets   = [for k, v in var.azs : cidrsubnet(var.cidr, 8, k + 52)]

  create_egress_only_igw = true
  enable_nat_gateway = true
  single_nat_gateway = true

  private_subnet_tags = merge(local.basic_tags, {
    "kubernetes.io/role/internal-elb" = 1
    "karpenter.sh/discovery"          = local.name
  })
  public_subnet_tags = merge(local.basic_tags, {
    "kubernetes.io/role/elb" = 1
  })

  reuse_nat_ips       = true
  external_nat_ip_ids = aws_eip.nat.*.id

  tags = local.basic_tags
}