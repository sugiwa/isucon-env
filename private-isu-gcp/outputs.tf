output "host_ip" {
  value = module.app.ip
}

output "user" {
  value = module.app.username
}

output "key_pass" {
  value = module.app.ssh_key_path
}