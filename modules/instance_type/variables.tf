variable "vcpu" {
  type        = string
  default     = 2
  description = "VCPU"
}

variable "memory" {
  type        = string
  default     = 4
  description = "Memory in unit of GIB."
}

variable "family" {
  type        = list(string)
  default     = ["m6*", "t2*"]
  description = "Instance family."
}
