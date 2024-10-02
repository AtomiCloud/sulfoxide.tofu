variable "landscape" {
  type = string
}

variable "cluster" {
  type = string
}

// example sgp1
// curl "https://api.vultr.com/v2/regions" | jq
variable "region" {
  type = string
}

// example v1.30.3+1
// curl https://api.vultr.com/v2/kubernetes/versions | jq
variable "k8s_version" {
  type = string
}

// example vc2-4c-8gb
// curl "https://api.vultr.com/v2/plans" | jq '.plans[].id'
variable "instance_type" {
  type = string
}

variable "min_nodes" {
  type = number
}

variable "max_nodes" {
  type = number
}