locals {
  canonical_owner_id  = "099720109477"
  rockylinux_owner_id = "792107900819"
}

data "aws_ami" "ami" {
  most_recent = true
  owners = [
    local.canonical_owner_id,
    local.rockylinux_owner_id
  ]

  filter {
    name   = "name"
    values = [var.ami_name]
  }
}
