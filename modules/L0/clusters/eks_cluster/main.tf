module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20"

  cluster_name                   = local.name
  cluster_version                = var.k8s_version
  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  cluster_enabled_log_types = var.log_types

  cluster_addons = {
    coredns = {
      configuration_values = jsonencode({
        computeType = "fargate"
        nodeSelector = var.single_az ? { "topology.kubernetes.io/zone" = local.az } : {}
        resources = {
          limits = {
            cpu = "0.25"
            memory = "256M"
          }
          requests = {
            cpu = "0.25"
            memory = "256M"
          }
        }
      })
    }
    kube-proxy = {}
    vpc-cni = {
      configuration_values = jsonencode({
        env = {
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET = "1"
          WARM_IP_TARGET = "5"
          MINIMUM_IP_TARGET = "2"
        }
      })
    }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  create_cluster_security_group = false
  create_node_security_group    = false

  fargate_profiles = {
    kube-system = {
      selectors = [
        { namespace = "kube-system" }
      ]
    }
  }
  tags = merge(local.basic_tags, {
    "karpenter.sh/discovery" = local.name
  })
}


