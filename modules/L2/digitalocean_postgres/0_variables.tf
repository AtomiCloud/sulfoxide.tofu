# service tree
variable "landscape" {
  type = string
}

variable "platform" {
  type = string
}

variable "service" {
  type = string
}

variable "module" {
  type = string
}


# db config
variable "region" {
  description = "Region name"
  type        = string
}

variable "size" {
  description = "Database size"
  type        = string
  default     = "db-s-1vcpu-1gb"
}

variable "databases" {
  description = "Map of databases"
  type        = map(string)
}

