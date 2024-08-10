variable "name" {
  type = string
}

variable "server" {
  type = string
}

variable "config" {
  type = string
  sensitive = true
}

variable "resources_name" {
  type = string
}

variable "namespace" {
  type = string
}