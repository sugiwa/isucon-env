resource "tls_private_key" "ssh_private_key" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "aws_key_pair" "this" {
  key_name   = var.ssh_key_name
  public_key = tls_private_key.ssh_private_key.public_key_openssh
}

resource "local_sensitive_file" "keypair_pem" {
  filename        = "${path.root}/.ssh/${var.ssh_key_name}.pem"
  content         = tls_private_key.ssh_private_key.private_key_pem
  file_permission = 600
}