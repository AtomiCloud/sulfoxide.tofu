# locals {
#   combinations = flatten([
#     for k1, v1 in local.infisical_landscapes.a : [
#       for k2, v2 in local.infisical_landscapes.v : {
#         key = "${k1}-${k2}"
#         value = {
#           physical = k1
#           virtual = k2
#         }
#       }
#     ]
#   ])
# }
#
# output "sample" {
#   value = local.combinations
# }
