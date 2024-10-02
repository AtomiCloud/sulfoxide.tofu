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

variable "databases" {
  description = "Map of databases"
  type        = map(string)
}

