# service tree
variable "landscape" {
  type        = string
  description = "Service Tree's landscape label"
}

variable "cluster" {
  type        = string
  description = "Service Tree's cluster label"
}

# meta
variable "additional_tags" {
  type = map(string)
  description = "Additional tags to apply to resources"
  default = {}
}

# EKS
variable "ips" {
  description = "Number of IPs to allocate to the NAT gateways"
  type        = number
}

variable "irsa_platform" {
  type        = string
  description = "IRSA platform"
}

variable "ebs_sa" {
  type        = string
  description = "EBS service account"
}

variable "efs_sa" {
  type        = string
  description = "EFS service account"
}

variable "elb_sa" {
  type        = string
  description = "Load balancer service account"
}

variable "karpenter_service_account" {
  type        = string
  description = "Karpenter service account"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "k8s_version" {
  type        = string
  description = "Kubernetes version"
}

variable "log_types" {
  type        = list(string)
  description = "Log types to enable"
  default     = []
}

# Network
variable "cidr" {
  type        = string
  description = "CIDR block for VPC"
}

variable "azs" {
  type = list(string)
  description = "Availability zones"
}

variable "single_az" {
  type        = bool
  description = "Use single AZ"
  default     = false
}

variable "single_az_index" {
  type        = number
  description = "Index of single AZ"
  default     = 0
}

# AWS
variable "access_key" {
  type        = string
  description = "AWS access key"
}

variable "secret_key" {
  type        = string
  description = "AWS secret key"
}