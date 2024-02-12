output "vpc" {
  value = data.aws_vpc.default
}

output "subnet" {
  value = aws_subnet.k8s
}

output "security_group" {
  value = aws_security_group.k8s
}
