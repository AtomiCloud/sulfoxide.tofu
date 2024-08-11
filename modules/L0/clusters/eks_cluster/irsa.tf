module "iam_eks_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  role_name = "${local.name}-irsa"


  attach_ebs_csi_policy                  = true
  attach_efs_csi_policy                  = true
  attach_load_balancer_controller_policy = true

  oidc_providers = {
    default = {
      provider_arn = module.eks.oidc_provider_arn
      namespace_service_accounts = [
        "${var.irsa_platform}:${var.ebs_sa}",
        "${var.irsa_platform}:${var.efs_sa}",
        "${var.irsa_platform}:${var.elb_sa}",
      ]
    }
  }
}