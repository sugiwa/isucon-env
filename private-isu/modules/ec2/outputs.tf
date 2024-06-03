output "instance_host_dns" {
  value = aws_instance.isu_instance.public_dns
}

output "ssh_key_name" {
  value = aws_key_pair.this.key_name
}