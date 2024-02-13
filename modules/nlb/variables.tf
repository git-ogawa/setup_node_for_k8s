variable "project_name" {
  type        = string
  description = "Project name"
  default     = "k8s"
}

variable "nlb_name" {
  type        = string
  description = "NLB name"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID"
}

variable "security_group_id" {
  type        = string
  description = "Security Group ID"
}

variable "instance_ids" {
  type        = list(string)
  description = "Instance IDs"
}

