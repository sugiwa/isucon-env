# secret key
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "local_sensitive_file" "ssh_private_key" {
  filename        = "${path.root}/${var.ssh_key_path}"
  content         = tls_private_key.ssh_key.private_key_pem
  file_permission = 600
}

variable "username" {
  default = "test"
}

variable "ssh_key_path" {
  default = ".ssh/id_rsa"
}

output "username" {
  value = var.username
}

output "ssh_key_path" {
  value = "${path.root}/${var.ssh_key_path}"
}