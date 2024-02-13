data "aws_vpc" "default" {
  default = true
}

resource "aws_subnet" "k8s" {
  vpc_id                  = data.aws_vpc.default.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name    = "${var.project_name}-subnet"
    Project = var.project_name
  }
}

resource "aws_security_group" "k8s" {
  name        = "${var.project_name}-sg"
  description = "security_group for k8s"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name    = "${var.project_name}-sg"
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "icmp" {
  security_group_id = aws_security_group.k8s.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "icmp"
  from_port         = -1
  to_port           = -1
  tags = {
    Name = "ping"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.k8s.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  tags = {
    Name = "http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.k8s.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  tags = {
    Name = "https"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.k8s.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  tags = {
    Name = "ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "api_server" {
  security_group_id = aws_security_group.k8s.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 6443
  to_port           = 6443
  tags = {
    Name = "api server"
  }
}

resource "aws_vpc_security_group_ingress_rule" "etcd_client" {
  security_group_id = aws_security_group.k8s.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 2379
  to_port           = 2380
  tags = {
    Name = "etcd client"
  }
}

resource "aws_vpc_security_group_ingress_rule" "kubelet_api" {
  security_group_id = aws_security_group.k8s.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 10250
  to_port           = 10250
  tags = {
    Name = "kubelet api"
  }
}

resource "aws_vpc_security_group_ingress_rule" "kube_scheduler" {
  security_group_id = aws_security_group.k8s.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 10259
  to_port           = 10259
  tags = {
    Name = "kube scheduler"
  }
}

resource "aws_vpc_security_group_ingress_rule" "kube_controller_manager" {
  security_group_id = aws_security_group.k8s.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 10257
  to_port           = 10257
  tags = {
    Name = "kube controller manager"
  }
}


resource "aws_vpc_security_group_ingress_rule" "nodeport" {
  security_group_id = aws_security_group.k8s.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 30000
  to_port           = 32767
  tags = {
    Name = "nodeport"
  }
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.k8s.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
