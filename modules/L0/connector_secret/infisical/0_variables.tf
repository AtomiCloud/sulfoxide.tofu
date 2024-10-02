variable "landscape" {
  type        = string
  description = "Landscape to deploy"
}

variable "project_name" {
  type    = string
  default = "Name of project to store secrets"
}

variable "secret_name" {
  type        = string
  description = "Name of Secret to write as"
}

variable "name" {
  type = string
}

variable "server" {
  type = string
}

variable "config" {
  type = string
}