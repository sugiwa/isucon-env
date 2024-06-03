output "instance_host" {
  value = module.app_instance.instance_host_dns
}

output "ssh_key" {
  value = module.app_instance.ssh_key_name
}