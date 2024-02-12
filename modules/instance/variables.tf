variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "security_group" {
  type = string
}

variable "subnet" {
  type = string
}

variable "project_name" {
  type    = string
  default = "k8s"
}

variable "hostname" {
  type    = string
  default = "k8s"
}
