locals {
  memory_in_mib = var.memory * 1024
}

data "aws_ec2_instance_types" "type" {
  filter {
    name   = "instance-type"
    values = var.family
  }
  filter {
    name   = "memory-info.size-in-mib"
    values = [local.memory_in_mib]
  }
  filter {
    name   = "vcpu-info.default-vcpus"
    values = [var.vcpu]
  }
}

