// service tree
variable "project" {
  description = "Project to perform referencing"
  type        = string
}

variable "physical_landscapes" {
  description = "Physical Landscapes"
  type        = map(string)
}

variable "virtual_landscapes" {
  description = "Virtual Landscapes"
  type        = map(string)
}

variable "secret" {
  description = "Secret to reference"
  type        = string
}