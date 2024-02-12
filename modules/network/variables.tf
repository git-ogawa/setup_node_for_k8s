variable "subnet_cidr" {
  type        = string
  description = "Subnet CIDR."
}

variable "project_name" {
  type        = string
  default     = "k8s"
  description = "Project name"
}
