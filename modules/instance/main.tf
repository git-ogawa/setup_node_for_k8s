resource "aws_instance" "instance" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [var.security_group]
  subnet_id       = var.subnet

  tags = {
    Name    = var.hostname
    Project = var.project_name
  }
  root_block_device {
    volume_size = 20
  }
  user_data = <<-EOF
    #!/bin/bash
    hostnamectl set-hostname ${var.hostname}
    touch /home/ubuntu/test.txt
  EOF
}

